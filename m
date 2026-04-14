Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DADF9D0ED
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 18:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47CC74028F;
	Tue, 14 Apr 2026 20:31:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4AF714028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 20:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776191492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=Pgf3ziEAq7EqNqjdaDmmJxGi4mdKHK2HOxSHGBR2d9Y=;
 b=QEOnVqVMCweLT10DeCxI9XG93/5pgGv58dIusM2HLH9k7FKOo2JSn8G9vdonyeqRuyu4Kv
 pxPqtqCS5HWPrl7ujUogEWGpt1ewRWt+sO1V9tQtOn+aXkb9Jzbco4jt6v+70j/Z7j+n+a
 8bepkeCsjgk11WX7iqyNpEbhW37ibrk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-YtA5ShVCNd-4dgJTLNWJRQ-1; Tue,
 14 Apr 2026 14:31:31 -0400
X-MC-Unique: YtA5ShVCNd-4dgJTLNWJRQ-1
X-Mimecast-MFC-AGG-ID: YtA5ShVCNd-4dgJTLNWJRQ_1776191490
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55CC918002C0; Tue, 14 Apr 2026 18:31:30 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B77493000C1D; Tue, 14 Apr 2026 18:31:29 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: techboard@dpdk.org, dev@dpdk.org
Subject: Meeting Minutes, March 04, 2026
Date: Tue, 14 Apr 2026 14:31:27 -0400
Message-ID: <f7to6jl9yww.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CKm7TC7M4Vc91cMUL49HXV1KtexFdiE4XGGyhaiaEL0_1776191490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

* TB Attendees
** Aaron Conole
** Thomas Monjalon
** Stephen Hemminger
** Jerin Jacob Kollanukkaran
** Bruce Richardson
** Kevin Traynor
** Maxime Coquelin

Agenda

* regexdev
** The discussion concluded that using a software solution is more
   efficient than using hardware, because hardware is quite limited for
   this work and CPUs are now outperforming dedicated hardware.
** Question about dropping support
*** We discussed what happens with vendors, noting that vendors are not
    currently providing support.
*** We considered the appropriate timing to drop support, questioning
    whether September would be an acceptable date.
*** The decision to drop support is reversible if needed.
** It was decided that a deprecation notice must be sent out, well
   publicized via mailing lists, release notes, and other channels.
*** Thomas will ask Ori to send out the deprecation materials.

* gpudev
** Maintenance appears to be lagging and requires attention, which
   includes adding examples.
** The current recommendation is to leave everything unchanged for the
   time being.

* Conference Update(s)
** The Call for Papers (CFP) review is scheduled for the 10th of March
   at 11am EST.
*** The submissions received thus far look good.
** Nathan gave timing and logistics updates for the tech board and gov
   board discussions.
** We requested a spreadsheet containing the abstracts and scores.

* Project Updates
** Nathan will be on leave; the interim contact is Yarille Ortiz
   (yortiz@linuxfoundation.org).
** Slack Pro
*** Feature: The archives are searchable.

* Bugzilla triage
** Stephen is writing Python scripts to gather information.
** Thomas has begun work on a dashboard (https://issues.dpdk.org) that
   ties together CI, Bugzilla, minutes, and development.
** We plan to discuss this with the government board and tech board.
** Features like:
*** A "wishlist" filtering option.
*** A to-do list.
*** The possibility of adding milestones to Bugzilla and filtering them here.
*** The use of an API key to assign bugs to maintainers.
** Considerations for the next meeting
*** Workflow for wishes.
*** Workflow for beginner tasks.

* AI Review status
** Current items:
*** Checkpatch should not serve as a gating step because it often
    generates false positives.
*** Build failures should remain a gating step.
** AGENTS.md
*** The file still contains a large number of tokens, but we are working
    on trimming it down.
*** Stephen is identifying more targeted prompt adjustments.
** UNH needs a final gating policy and a process for submission.

* Followups (things like checkpatch, maintainer list, etc.)
** Thomas scrubbed the maintainers list for inactive individuals.

