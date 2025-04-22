Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A6C369CB
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 16:52:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F279F40156;
	Tue, 22 Apr 2025 18:52:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A46F440151
 for <dev@dpdk.org>; Tue, 22 Apr 2025 18:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745340776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=YmtnqNAtes1AmwIoxqnEu4foHg5bhCaKxeDDK7Jan8k=;
 b=acWmFBzjvFnljXBSNfYAz74UGrD68SP+3G/m6zZmcLzm7nsU7/fuE/wuB4L4IRPs4xT3w2
 xdFsDk8LOdyOWTtPAni8GTQLFkE7JBg3glzCTc6+3aZbVIw/nv4O+TdTlvy1u46IXDsYpY
 fHgSFGb3hjHe6Y84uNPldhLEVEMBw5E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-aJNUJetaP46F5jmpnRbj6g-1; Tue,
 22 Apr 2025 12:52:52 -0400
X-MC-Unique: aJNUJetaP46F5jmpnRbj6g-1
X-Mimecast-MFC-AGG-ID: aJNUJetaP46F5jmpnRbj6g_1745340771
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A102180087B; Tue, 22 Apr 2025 16:52:51 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E9CA30001A2; Tue, 22 Apr 2025 16:52:49 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: dev@dpdk.org, ci@dpdk.org, dev@openvswitch.org
Cc: Michael Santana <msantana@redhat.com>, Flavio Leitner <fbl@redhat.com>
Subject: [NOTICE] Github Robot: Missing Reports
Date: Tue, 22 Apr 2025 12:52:47 -0400
Message-ID: <f7tecxkcf4w.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BlfOJZPoGU1JaJbmWi0QPB0TELLLMWELOhFjMgOq6fY_1745340771
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

Greetings,

Last week on April 16th, there was a disruption with the credentials for
the github robot's email reporting.  Patches were submitted to github,
but the emails that were supposed to report status did not get sent out.

The issue has been resolved as of April 22nd.  If you see a series with
a missing report, it should be possible to just ask for a recheck.

Thanks,
-Aaron

