// Example model schema from the Drizzle docs
// https://orm.drizzle.team/docs/sql-schema-declaration

import { sql } from "drizzle-orm";
import {
  index,
  pgTableCreator,
  serial,
  timestamp,
  varchar,
  integer,
  uuid,
  boolean,
  text,
} from "drizzle-orm/pg-core";

/**
 * This is an example of how to use the multi-project schema feature of Drizzle ORM. Use the same
 * database instance for multiple projects.
 *
 * @see https://orm.drizzle.team/docs/goodies#multi-project-schema
 */
export const createTable = pgTableCreator((name) => `zillow-clone_${name}`);

export const posts = createTable(
  "post",
  {
    id: serial("id").primaryKey(),
    name: varchar("name", { length: 256 }),
    createdAt: timestamp("created_at", { withTimezone: true })
      .default(sql`CURRENT_TIMESTAMP`)
      .notNull(),
    updatedAt: timestamp("updated_at", { withTimezone: true }).$onUpdate(
      () => new Date(),
    ),
  },
  (example) => ({
    nameIndex: index("name_idx").on(example.name),
  }),
);

// Users Table (linked with Clerk)
export const users = createTable("users", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  clerkId: varchar("clerk_id", { length: 255 }).unique().notNull(), // Clerk User ID
  email: varchar("email", { length: 255 }).unique().notNull(),
  name: varchar("name", { length: 255 }).notNull(),
  role: varchar("role", { length: 50 }).default("buyer").notNull(), // Roles like 'buyer', 'agent', 'admin'
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

// Agent Profiles Table
export const agentProfiles = createTable("agent_profiles", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  userId: uuid("user_id")
    .references(() => users.id)
    .notNull(), // FK to Users (Agent role)
  bio: text("bio"),
  licenseNumber: varchar("license_number", { length: 50 }).notNull(),
  agencyId: uuid("agency_id").references(() => agencies.id), // FK to agencies (if applicable)
  contactPhone: varchar("contact_phone", { length: 20 }),
  officeAddress: text("office_address"),
});

// Agencies Table
export const agencies = createTable("agencies", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  name: varchar("name", { length: 255 }).notNull(),
  address: text("address"),
  contactEmail: varchar("contact_email", { length: 255 }).notNull(),
  phoneNumber: varchar("phone_number", { length: 20 }),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

// Properties Table
export const properties = createTable("properties", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  title: varchar("title", { length: 255 }).notNull(),
  description: text("description").notNull(),
  price: integer("price").notNull(),
  address: varchar("address", { length: 255 }).notNull(),
  city: varchar("city", { length: 100 }).notNull(),
  state: varchar("state", { length: 100 }).notNull(),
  zipCode: varchar("zip_code", { length: 20 }).notNull(),
  numberOfBedrooms: integer("number_of_bedrooms").notNull(),
  numberOfBathrooms: integer("number_of_bathrooms").notNull(),
  squareFeet: integer("square_feet").notNull(),
  lotSize: integer("lot_size"),
  listingDate: timestamp("listing_date").defaultNow().notNull(),
  isAvailable: boolean("is_available").default(true),
  agentId: uuid("agent_id")
    .references(() => users.id)
    .notNull(), // FK to users (Agent)
});

// Property Images Table
export const propertyImages = createTable("property_images", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  propertyId: uuid("property_id")
    .references(() => properties.id)
    .notNull(), // FK to Properties
  imageUrl: varchar("image_url", { length: 500 }).notNull(),
});

// Favorites Table
export const favorites = createTable("favorites", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  userId: uuid("user_id")
    .references(() => users.id)
    .notNull(), // FK to Users (Buyer)
  propertyId: uuid("property_id")
    .references(() => properties.id)
    .notNull(), // FK to Properties
  savedAt: timestamp("saved_at").defaultNow().notNull(),
});

// Inquiries Table
export const inquiries = createTable("inquiries", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  userId: uuid("user_id")
    .references(() => users.id)
    .notNull(), // FK to Users (Buyer)
  propertyId: uuid("property_id")
    .references(() => properties.id)
    .notNull(), // FK to Properties
  message: text("message").notNull(),
  contactEmail: varchar("contact_email", { length: 255 }).notNull(),
  sentAt: timestamp("sent_at").defaultNow().notNull(),
});

// Reviews Table
export const reviews = createTable("reviews", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  userId: uuid("user_id")
    .references(() => users.id)
    .notNull(), // FK to Users
  agentId: uuid("agent_id").references(() => users.id), // FK to Agents
  propertyId: uuid("property_id").references(() => properties.id), // FK to Properties
  rating: integer("rating").notNull(),
  reviewText: text("review_text"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

// Appointments Table
export const appointments = createTable("appointments", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  userId: uuid("user_id")
    .references(() => users.id)
    .notNull(), // FK to Users (Buyer)
  propertyId: uuid("property_id")
    .references(() => properties.id)
    .notNull(), // FK to Properties
  agentId: uuid("agent_id")
    .references(() => users.id)
    .notNull(), // FK to Agents
  appointmentDate: timestamp("appointment_date").notNull(),
  status: varchar("status", { length: 50 }).default("pending").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

// Property Tags Table
export const tags = createTable("tags", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  name: varchar("name", { length: 100 }).unique().notNull(),
});

export const propertyTags = createTable("property_tags", {
  id: uuid("id").defaultRandom().primaryKey(), // UUID instead of serial
  propertyId: uuid("property_id")
    .references(() => properties.id)
    .notNull(), // FK to Properties
  tagId: uuid("tag_id")
    .references(() => tags.id)
    .notNull(), // FK to Tags
});
