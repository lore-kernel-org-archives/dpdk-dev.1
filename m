Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A7C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26EBF402AC;
	Mon, 11 Aug 2025 15:05:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8722D40C35
 for <dev@dpdk.org>; Mon, 11 Aug 2025 15:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754917522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CZLV7Jg0zqZbONlqQbPhw7bHpyB6UH6NESTL++c+zos=;
 b=L2Cf2gZ9Iiu/9ywf2pvdfpxNiE7b59jpJl4dJUCvu5nlkdgFz7ZVLdN93vt3Zj4Rv412Rk
 IBl9okeVg8G/kZFlKFT3WKFw2Joig3O5McWDbWpYPbICGzT0P11ibP/uBgFrQoqiv3Junw
 h0x9Qrl7k3x7QGdwxRTwq2LhqY3j3Tk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-LAGiK0WRPkarYIjDQ-pDXA-1; Mon,
 11 Aug 2025 09:05:19 -0400
X-MC-Unique: LAGiK0WRPkarYIjDQ-pDXA-1
X-Mimecast-MFC-AGG-ID: LAGiK0WRPkarYIjDQ-pDXA_1754917518
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F10A818002D6; Mon, 11 Aug 2025 13:05:17 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.155])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3157519560AD; Mon, 11 Aug 2025 13:05:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: dev@dpdk.org, techboard@dpdk.org
Subject: Meeting Minutes - Mar. 19, 2025
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 11 Aug 2025 09:05:15 -0400
Message-ID: <f7t4iueuhys.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8sP3BLOEG6w-Yd1RGZCCKt0g1DAKxuw3zTMRxUxb2HI_1754917518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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


Attendees:
- Aaron Conole
- Bruce Richardson
- Honnappa Nagarahalli
- Maxime Coquelin
- Morten Br=C3=B8rup
- Thomas Monjalon

1. Board initiatives follow up
 - Cloud, AI, security initiatives
 - No discussion on this topic.

2. Gov board
 - any proposals for following up (meeting on Mar. 20, Q1 sync)
 - Requested an update on DTS developer progress (Morten provided)
 - Maxime still has outstanding request to Gov Board about linux header
   file inclusion for UAPI (Nathan to share with Maxime)
 - Anyone else reach out to Nathan if there are initiatives

3. Code challenge
 - Thomas created a google sheet as a starting point for discussions,
   tech board
 - Approval from Gov Board / Mkt for $$ to be associated with this as
   some kind of prize/reward/incentive?
   - Prizes of some kind are needed to generate interest
   - How to determine prize?  Dates?  Can travel be part of it?
 - Tech board to vote on preferences for projects
 - Tech board then will need to pick / propose / prioritize topics based
   on the preferences
 - Reach out to universities about topics
 - Mentorship sign up for topics and for general mentorship
 - Format is fine, but concern is about mentorship and who will be able
   to volunteer
 - Bring up to Governing board
   1. Explain the current status
   2. Explain the topics and what we are proposing
   3. Ask for assistance with getting mentors

4. Contribution policy
 - Feedback
   - Mailing list being write-only may not change even with this
     proposal
   - Patch mailing list is really just a CI mailing list at this point
 - Waiting before re-posting as PATCH
 - Concern about how the CI usage will be affected, may not accomplish
   goals (circular feedback loop)
 - Maybe need to post with ominous name

5. Grout testing at UNH
 - Ask Patrick to discuss in email on tech board on the current status
   - Aaron to send
 - To be discussed next meeting

6. Prague Update
 - Swag, restaurant arrangements for joint sessions
 - Tech board to send in reimbursement requests now
 - Schedule being online?  DPDK events page and prague pages are giving
   Error 404

Next meeting: 02 April, 2025
Chair: Bruce Richardson

