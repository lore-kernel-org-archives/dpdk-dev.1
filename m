Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2316606A5A9
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JoJ66GKm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 711FD40E34;
	Mon,  2 Nov 2026 15:41:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 8BE2140E1F
 for <dev@dpdk.org>; Mon,  2 Nov 2026 15:41:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uKntg8pvOutnNbDkGYPV+x9Kstc9e5aLL6daMKR7KIA=;
 b=JoJ66GKmczLfaCy6EVLAaXnbRmzzezpVKwdDBrZy0XctUpkW4HI9Xysb8QBD3plSn+M/17
 VgKtWKWN2GTs8KHFOjrR6S1LJ26BEK9kefbVk2MG0UgFOuk3sIHSxJikUE0jaOKDvOUH3s
 FxTr03ef12XK9MdczK5ExRIPxmwpSVc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-3kf_botZMxKqQLEwYunzLg-1; Mon, 02 Nov 2026 09:41:46 -0500
X-MC-Unique: 3kf_botZMxKqQLEwYunzLg-1
X-Mimecast-MFC-AGG-ID: 3kf_botZMxKqQLEwYunzLg_1793630505
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3ac48d0f87fso17952071fa.0
 for <dev@dpdk.org>; Mon, 02 Nov 2026 06:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630505; x=1794235305;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uKntg8pvOutnNbDkGYPV+x9Kstc9e5aLL6daMKR7KIA=;
 b=11iUUQueog4/gwYUR1O31eBvz/v5JADyT5YdzeKLGlhmlH1DgSzqKHxwMILG2UzJ+x
 fWS4juA7HggZCCkNlnsvx1YxETXLoLAJ6s6trJ6pJEuukSqn5rqIi/kQp+Dg3pj6w2DS
 JNj2OACZThWFE8UXm/QKgZRhQJoWEdd1tF6opJoKc2Vf/AGPkcWBUS27k51dwpCBc/fD
 L0lQbH05g0Q57PuaDEuSZiaN65d+PKIh7wq/xkv25RPIgS3Bz3kqsQhur3rD2N9K/Nh5
 CcGD7FoUDYMAXslJDoPogoYnKmOHkHOyKExguxiac723wfnHCdJWscGgqx1dCQv3omd+
 uEYw==
X-Gm-Message-State: APuU4Z+VNHoiws5/zgbDAKrA6oLySfWXCljj33D+izaIe9vFV2bjEo7e
 tng30mDVzrfIOlfOz48GkgneSb8I8zxsgeQZpPDxspVfxZIqSpfjQq9/Ux6PdhOibW+JKe0Ry7V
 zIADQ5OrzQ10DYyH3Wh8R45WIwuqnj6RFxlbcdUGte8GU5AM940kR8CIEbvTcORxQGLBfAAllTL
 asv0UbMX6awYiiK/wnaKy1RZKzXvNKPg==
X-Gm-Gg: AYBFou05zpSAe5qBW9BLHGym1W2R+81F2/4ix+JnEmM6TaILylpwDLKaGODR6TLeeeb
 V4mtVCq1Q+Yd34W8qduq+NkZMKFKJ+Zevd/HFalVdwLwF10V0dm885Jl80OWQs6eAiHxfnYLmRM
 eQwdVLyAs1Zm5zaeLFDj5D2bAA9gcjX/NUupvl8WMhWskx1XOfZ2ONy2zvXXhopyFNTJwCCu3wz
 7qtD+K6R23mh8PGQPiitGp6bDCZrtirWkdhkSeJKGJkauhL
X-Received: by 2002:a05:651c:4198:b0:3ab:53ca:c746 with SMTP id
 38308e7fff4ca-3acb7a9a3f9mr28943961fa.12.1793630504849; 
 Mon, 02 Nov 2026 06:41:44 -0800 (PST)
X-Received: by 2002:a05:651c:4198:b0:3ab:53ca:c746 with SMTP id
 38308e7fff4ca-3acb7a9a3f9mr28943921fa.12.1793630504364; Mon, 02 Nov 2026
 06:41:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027150748.1170031-1-stephen@networkplumber.org>
 <20261027202949.1034659-1-stephen@networkplumber.org>
In-Reply-To: <20261027202949.1034659-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 2 Nov 2026 15:41:32 +0100
X-Gm-Features: AclHuK8herdhoduNmpCff_Pb2BBVA_ZHKi5OggO3S9OCnflAv5N37ZKd5B2cN6Q
Message-ID: <CAJFAV8y8MPO+yse6_Dks2sKstp49cBpinz7-+geq2XPrdjLsWw@mail.gmail.com>
Subject: Re: [PATCH v3] Revert "examples/symmetric_mp: do not print or exit in
 handler"
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zFoBQUgaR2PzAyKQmAwLwLhiMpsJolnaIAoTnR-BRm4_1793630505
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 21:30, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This reverts commit 9a0b3c409db1963a92d0a91868b1e45254845a8c.
>
> With that change the primary calls rte_eal_cleanup() on SIGINT
> while secondaries are still polling the shared queues, which
> crashes the secondaries.
>
> Doing shutdown correctly in a multi-process application needs
> both processes to monitor each other and handle termination and
> unexpected exit. That is too complex for an example; go back to
> the simple exit from the signal handler.
>
> Bugzilla ID: 2069
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


-- 
David Marchand

