CREATE TABLE IF NOT EXISTS "zillow-clone_agencies" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar(255) NOT NULL,
	"address" text,
	"contact_email" varchar(255) NOT NULL,
	"phone_number" varchar(20),
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_agent_profiles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" integer NOT NULL,
	"bio" text,
	"license_number" varchar(50) NOT NULL,
	"agency_id" integer,
	"contact_phone" varchar(20),
	"office_address" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_appointments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" integer NOT NULL,
	"property_id" integer NOT NULL,
	"agent_id" integer NOT NULL,
	"appointment_date" timestamp NOT NULL,
	"status" varchar(50) DEFAULT 'pending' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_favorites" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" integer NOT NULL,
	"property_id" integer NOT NULL,
	"saved_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_inquiries" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" integer NOT NULL,
	"property_id" integer NOT NULL,
	"message" text NOT NULL,
	"contact_email" varchar(255) NOT NULL,
	"sent_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_messages" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"sender_id" integer NOT NULL,
	"receiver_id" integer NOT NULL,
	"message_text" text NOT NULL,
	"sent_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_notifications" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" integer NOT NULL,
	"notification_text" text NOT NULL,
	"is_read" boolean DEFAULT false NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_post" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" varchar(256),
	"created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"updated_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_properties" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" varchar(255) NOT NULL,
	"description" text NOT NULL,
	"price" integer NOT NULL,
	"address" varchar(255) NOT NULL,
	"city" varchar(100) NOT NULL,
	"state" varchar(100) NOT NULL,
	"zip_code" varchar(20) NOT NULL,
	"number_of_bedrooms" integer NOT NULL,
	"number_of_bathrooms" integer NOT NULL,
	"square_feet" integer NOT NULL,
	"lot_size" integer,
	"listing_date" timestamp DEFAULT now() NOT NULL,
	"is_available" boolean DEFAULT true,
	"agent_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_property_images" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"property_id" integer NOT NULL,
	"image_url" varchar(500) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_property_tags" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"property_id" integer NOT NULL,
	"tag_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_property_visits" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" integer,
	"property_id" integer NOT NULL,
	"visit_type" varchar(50) NOT NULL,
	"visit_date" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_reviews" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" integer NOT NULL,
	"agent_id" integer,
	"property_id" integer,
	"rating" integer NOT NULL,
	"review_text" text,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_tags" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar(100) NOT NULL,
	CONSTRAINT "zillow-clone_tags_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "zillow-clone_users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"clerk_id" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"name" varchar(255) NOT NULL,
	"role" varchar(50) DEFAULT 'buyer' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "zillow-clone_users_clerk_id_unique" UNIQUE("clerk_id"),
	CONSTRAINT "zillow-clone_users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_agent_profiles" ADD CONSTRAINT "zillow-clone_agent_profiles_user_id_zillow-clone_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_agent_profiles" ADD CONSTRAINT "zillow-clone_agent_profiles_agency_id_zillow-clone_agencies_id_fk" FOREIGN KEY ("agency_id") REFERENCES "public"."zillow-clone_agencies"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_appointments" ADD CONSTRAINT "zillow-clone_appointments_user_id_zillow-clone_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_appointments" ADD CONSTRAINT "zillow-clone_appointments_property_id_zillow-clone_properties_id_fk" FOREIGN KEY ("property_id") REFERENCES "public"."zillow-clone_properties"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_appointments" ADD CONSTRAINT "zillow-clone_appointments_agent_id_zillow-clone_users_id_fk" FOREIGN KEY ("agent_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_favorites" ADD CONSTRAINT "zillow-clone_favorites_user_id_zillow-clone_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_favorites" ADD CONSTRAINT "zillow-clone_favorites_property_id_zillow-clone_properties_id_fk" FOREIGN KEY ("property_id") REFERENCES "public"."zillow-clone_properties"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_inquiries" ADD CONSTRAINT "zillow-clone_inquiries_user_id_zillow-clone_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_inquiries" ADD CONSTRAINT "zillow-clone_inquiries_property_id_zillow-clone_properties_id_fk" FOREIGN KEY ("property_id") REFERENCES "public"."zillow-clone_properties"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_messages" ADD CONSTRAINT "zillow-clone_messages_sender_id_zillow-clone_users_id_fk" FOREIGN KEY ("sender_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_messages" ADD CONSTRAINT "zillow-clone_messages_receiver_id_zillow-clone_users_id_fk" FOREIGN KEY ("receiver_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_notifications" ADD CONSTRAINT "zillow-clone_notifications_user_id_zillow-clone_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_properties" ADD CONSTRAINT "zillow-clone_properties_agent_id_zillow-clone_users_id_fk" FOREIGN KEY ("agent_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_property_images" ADD CONSTRAINT "zillow-clone_property_images_property_id_zillow-clone_properties_id_fk" FOREIGN KEY ("property_id") REFERENCES "public"."zillow-clone_properties"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_property_tags" ADD CONSTRAINT "zillow-clone_property_tags_property_id_zillow-clone_properties_id_fk" FOREIGN KEY ("property_id") REFERENCES "public"."zillow-clone_properties"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_property_tags" ADD CONSTRAINT "zillow-clone_property_tags_tag_id_zillow-clone_tags_id_fk" FOREIGN KEY ("tag_id") REFERENCES "public"."zillow-clone_tags"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_property_visits" ADD CONSTRAINT "zillow-clone_property_visits_user_id_zillow-clone_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_property_visits" ADD CONSTRAINT "zillow-clone_property_visits_property_id_zillow-clone_properties_id_fk" FOREIGN KEY ("property_id") REFERENCES "public"."zillow-clone_properties"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_reviews" ADD CONSTRAINT "zillow-clone_reviews_user_id_zillow-clone_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_reviews" ADD CONSTRAINT "zillow-clone_reviews_agent_id_zillow-clone_users_id_fk" FOREIGN KEY ("agent_id") REFERENCES "public"."zillow-clone_users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "zillow-clone_reviews" ADD CONSTRAINT "zillow-clone_reviews_property_id_zillow-clone_properties_id_fk" FOREIGN KEY ("property_id") REFERENCES "public"."zillow-clone_properties"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "name_idx" ON "zillow-clone_post" USING btree ("name");