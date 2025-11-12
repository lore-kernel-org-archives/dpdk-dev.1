Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF08CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:03:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5550140697;
	Wed, 12 Nov 2025 16:03:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CAADC402B0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:03:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762959817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=jr6AYc7XUiLairwh9ZSDz2Nxtsbp256mSuTvtdyAniE=;
 b=WEk8c8R6u+uCyH/mYA/07lUOH+b0EWsahu8uTumiSFCPeDqXvUA7uJ1+TUT7KACykxiLWn
 OS74618Tn/9tdpxGOXyA5xs/NouOr+IKdX6idG+aCN2lydEpMQ3bMXMBpryFuMDeYe/cvW
 eEjYjuTx8WAenXT0Dlq+eS1smOFZJCY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-q51Gj4pHMXOoWwYwmRfwUw-1; Wed,
 12 Nov 2025 10:03:35 -0500
X-MC-Unique: q51Gj4pHMXOoWwYwmRfwUw-1
X-Mimecast-MFC-AGG-ID: q51Gj4pHMXOoWwYwmRfwUw_1762959814
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB5E4196E0BF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 15:03:23 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01B3E18009A7
 for <dev@dpdk.org>; Wed, 12 Nov 2025 15:03:22 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: dev@dpdk.org
Subject: Meeting Minutes, 2025-10-15
Date: Wed, 12 Nov 2025 10:03:21 -0500
Message-ID: <f7ttsyzfg3q.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jZz4rlf0MkeY8_r6CYySJ-ruL9DalL2kRopTs2phmH8_1762959814
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


Attendees: 8/11 TB
* Aaron Conole
* Bruce Richardson
* Hemant Agrawal
* Jerin Kollanukkaran
* Thomas Monjalon
* Maxime Coquelin
* Kevin Traynor
* Morten Brorup

NOTE: The Technical Board meetings take place every second Wednesday at 3 pm UTC
on https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=d808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes
The next meeting will happen on October 29
The next chair will be Hemant Agrawal

Topics

SOW Retrospective and priorities
* Priority is urgent due to Governing Board deadlines for budget
  decisions
* Patrick sent out a retrospective for the techboard review
* Aaron to kick off the tasks spreadsheet
* Morten asks about running DTS on the "single-server topology"
   * Patrick replies this is currently working with some effort, after
     the BoF discussion at DPDK Summit Prague
   * Paul and Patrick will look into updating the documentation
   * Maybe add this to the SOW for any additional documentation and
     development work to support it properly.
* How to read the retrospective?
   * Patrick to re-review the retrospective to make sure things are
     highlighted appropriately.  Highlighted items are still WIP or not
     planned to complete.

LTS Maintainer
* Should we advertise that we are seeking for someone to do this work
  on the mailing list publicly?
   * There could be someone who is active in the community but isn't
     aware that LTS maintainer-ship needs help.
   * Kevin will send something to the mailing list to try and seek
     candidates.

FAST_FREE vs multi-seg MBUF
* 3 options being discussed to resolve the incompatibility between
  fast-free vs. multi-segment mbuf flags
* Morten proposes that we roll back the mutual exclusivity
  enforcement patch.  This will restore the older behavior, and allow
  tests to run properly, given that tests are setting these flags.
* Better to roll back the patch because it isn't any worse that things
  were previously.
* Need to make a decision before RC-1, and changing this is an API/ABI
  semantic difference.
* Still haven't reached conclusion as what FAST_FREE means, which
  makes it difficult to evaluate the correctness of exclusion.
* VOTE to rollback: PASS - 8 votes for rolling back and postponing
  further discussion.

How to encourage more reviews on Dev ML
* Thomas notes that Tim O'Driscoll, Ben Thomas, and Nathan are also
  be engaged.
* Idea from Ben - maybe having 'credly' badges.
   * Maybe use AI Bot to flag reviews
* Morten is looking for more design and high-level reviews
   * Thomas says solution is to motivate the senior developers to do more
     reviews.
   * Morten has a dev ML, and then manually moves the patches he wants
     to review into a different folder.
* Question: How to flag important series?
   * Maybe an automatic way to flag certain areas of the code as high
     priority?
   * Dashboard may not motivate, but maybe it can help to organize the
     work
   * Maybe some way of prioritizing patches in patchwork - have a column
     and we can sort on this.
   * This helps with the finding what to review part, but doesn't help
     with motivation.
   * New column may be helpful anyway
   * who can work on the column?  Thomas will reach out to Ali
* Maybe metrics for review?
   * Difficult to get metrics, but they can be motivational
   * Challenge: Keeping the current reviewers motivated, and motivating
     the future reviewers.

AI Review requirements
* Apply the series to the correct branches to eliminate some of the
  noise.
* So far, only David seems to be reviewing
* Should have a different name.  'github-post' is not good enough,
  maybe 'AI-review' will get more attention.  Aaron will make that
  change.
* Preference would be to have a link directly.  Could be done as a new
  tag.
* Aaron to change the github-post label, and start discussions about
  a new tag that will do a direct link on the CI mailing list.
* For the future, 'How useful is this?  Should we investigate other AI
  review tools?'

