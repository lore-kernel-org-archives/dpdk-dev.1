Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85FAF3D330
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECEEB40A73;
	Thu,  5 Mar 2026 17:29:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 09CBF40647
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:29:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZYKA+DK7fSahZrjRcQPaFiYpKgdowUBjae3fi7fFVM=;
 b=MTJK2/O6MT8pL84+3N3ey4WKM+MRgRskqdcfMDBCt6gjgFqN4VNmyzYuKTjPu/4+NQFyCR
 6JBwYgqDPUb5n8TUo3CTuFgAzJitfget03aphtX8EqsbREpm5avdQ5TTirocTz+xtGOcGz
 mZKwc4uF0iVvBuWBBMhr9sIY9x8nPSM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-Tte-mb0MNUyrucUZnXt6Xg-1; Thu,
 05 Mar 2026 11:29:50 -0500
X-MC-Unique: Tte-mb0MNUyrucUZnXt6Xg-1
X-Mimecast-MFC-AGG-ID: Tte-mb0MNUyrucUZnXt6Xg_1772728189
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 081E719560B2; Thu,  5 Mar 2026 16:29:49 +0000 (UTC)
Received: from ringo.home (unknown [10.44.34.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 776681958DC5; Thu,  5 Mar 2026 16:29:47 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: grout@dpdk.org, dev@dpdk.org, Andrei Rybchenko <rybchenko.andrei@gmail.com>
Subject: Applied: [PATCH grout] infra: fix xconnect to send packets to peer
Date: Thu,  5 Mar 2026 17:29:43 +0100
Message-ID: <177272724792.413072.3297497555506219989@ringo>
In-Reply-To: <20260305112322.2149412-1-rybchenko.andrei@gmail.com>
References: <20260305112322.2149412-1-rybchenko.andrei@gmail.com>
MIME-Version: 1.0
X-Sourcehut-Patchset-Update: APPLIED
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IsPSmDWmK677Vtp6yysQKCbcPhBgfTKHwMUqgzDjcmU_1772728189
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Andrei Rybchenko <rybchenko.andrei@gmail.com> wrote:
> xconnect was broken some time ago and just loopback received
> packets to input interface, but count Tx on peer.
>
> There is no point to set port in mbuf since it is not actually
> used right now.
>
> Fixes: ba36a6b744ab ("eth_output: make output dependent on interface type")
> Signed-off-by: Andrei Rybchenko <rybchenko.andrei@gmail.com>
> ---

Hey Andrei,

Thanks for the fix!

Acked-by: Robin Jarry <rjarry@redhat.com>

Applied on main branch.

To git@github.com:DPDK/grout
   2d96173de60a..fbb78ef75aa9  main -> main

