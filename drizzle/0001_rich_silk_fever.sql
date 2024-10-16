DROP TABLE "zillow-clone_messages";--> statement-breakpoint
DROP TABLE "zillow-clone_notifications";--> statement-breakpoint
DROP TABLE "zillow-clone_property_visits";--> statement-breakpoint
ALTER TABLE "zillow-clone_agent_profiles" ALTER COLUMN "user_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_agent_profiles" ALTER COLUMN "agency_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_appointments" ALTER COLUMN "user_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_appointments" ALTER COLUMN "property_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_appointments" ALTER COLUMN "agent_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_favorites" ALTER COLUMN "user_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_favorites" ALTER COLUMN "property_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_inquiries" ALTER COLUMN "user_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_inquiries" ALTER COLUMN "property_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_properties" ALTER COLUMN "agent_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_property_images" ALTER COLUMN "property_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_property_tags" ALTER COLUMN "property_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_property_tags" ALTER COLUMN "tag_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_reviews" ALTER COLUMN "user_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_reviews" ALTER COLUMN "agent_id" SET DATA TYPE uuid;--> statement-breakpoint
ALTER TABLE "zillow-clone_reviews" ALTER COLUMN "property_id" SET DATA TYPE uuid;