Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C31606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWQeJFoP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED0E400D7;
	Tue, 27 Oct 2026 14:03:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 18030400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 14:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793106182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5BoXSewWfZv3Dwd3rXdZ23cG/YhnfCyxIFlWxKoT8A=;
 b=aWQeJFoPwvIivgsywzKR6upsE2bVqH0P2H5TQalgwdGdXcRt5o8Gcp12RhuDRWlbWvHdKe
 lXSKyeYAI5r/VUVo3F/nwJpZrw9W9TQIOq3Ockh5tECAytnjFWODrVWNIvIjMaGWmaptBt
 Na0ntDk+2FP7ujvQ9HjHr+LPvQyWunI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-ticqvAY0NmmFpwxJlOZZOQ-1; Tue, 27 Oct 2026 09:03:00 -0400
X-MC-Unique: ticqvAY0NmmFpwxJlOZZOQ-1
X-Mimecast-MFC-AGG-ID: ticqvAY0NmmFpwxJlOZZOQ_1793106179
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a59ac42cd8so19852461fa.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 06:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793106179; x=1793710979;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z5BoXSewWfZv3Dwd3rXdZ23cG/YhnfCyxIFlWxKoT8A=;
 b=jmEmifnXyyC6mgK1MBKWCSWTaFaFB7qvPOZKhMbPNq/xBsUjRh00tEffsojuxN4vrb
 2X/hwwYnSYTjRPWV6dUJnrQQcDd+/rIypxPO5LMgeIJegxPb3PXvwu4qIoL/sSzlNE3K
 tAx5IAJnEVZAMCd2iEM8cMUkAB5QRA0skrraVBC6Ek99JtEmsfryOZqmI56l/9ITjrpd
 PhlEXnbFHLeYPSO6wCjtVGmvNyB5ZQwQqQYClzJISvPBNLrC9Q62GjbYQt3dcBTuJ6pi
 JKk/eBUyD9rALUkEsJbK36Hi/Va2yDra96/r+G944dMjBO4XvQ18XN7rm1DzUFXNrlPe
 /TZA==
X-Gm-Message-State: AFq9FYJ1LDJqRahXkOYL0a5sD2AHoBWNnDUn5uoNFupBtYn9zZLwSbub
 3wQtmEvac21FYg91/m2IfSCp7yYCM9lw5ASZ+YFyB1mUj9ZiRBK4zbE70kUHoZZNsZ4w4ajPFFN
 OSdmXCHsRpjF8S3apkpkQ09uOlqLWPn9gGtoqR89kx6FJOKLmr9zRurblJWy6irvQ3Qm2XNJFwi
 wro3h/8BRWrIojv09Z3sQ=
X-Gm-Gg: AYBFou30DwMWoRU3zU8CbHXQBaUCTPwlaXQpHRpZfMuxKC9O9LiZPa3nivG5vbKQKhj
 2mPinLoSWW1wZzpE1cMboz0ItNIPsQQegISn2DMGUmqD25l/gLotKFC2uLGzB7LuiGXyxRa6gMI
 WnsP1i91jlDIJMjGriyjhxfTpNlPFtZc2kLiruSuuHNyGcHM+WPHDGB/qPoHm693hjOru3PqBuP
 TD4xJ089jdzZUC3k3kgQWyPpjiRP50T+EKEASConljF3hHS
X-Received: by 2002:a05:651c:2118:b0:3ab:4412:354b with SMTP id
 38308e7fff4ca-3ac6fb18df6mr23836371fa.1.1793106178928; 
 Tue, 27 Oct 2026 06:02:58 -0700 (PDT)
X-Received: by 2002:a05:651c:2118:b0:3ab:4412:354b with SMTP id
 38308e7fff4ca-3ac6fb18df6mr23836331fa.1.1793106178376; Tue, 27 Oct 2026
 06:02:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027095832.358077-1-david.marchand@redhat.com>
In-Reply-To: <20261027095832.358077-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 27 Oct 2026 14:02:46 +0100
X-Gm-Features: AclHuK8MCcUiKvnwokcQg8Ps8c78ZQ9wrb1MYtY_5cD1Euc2siV9bfu9OXa-6Ug
Message-ID: <CAJFAV8xHTKLFB-AgN5iMhVf5bhHk6qoGW82dpCD4MEYfbgi9AA@mail.gmail.com>
Subject: Re: [PATCH] net/i40e: fix MAC address removal without VMDq
To: bruce.richardson@intel.com
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oBS7G77LVJr6w0TAL43csWgoQ0oPOfywWe_Fp1iGTOQ_1793106179
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 10:59, David Marchand <david.marchand@redhat.com> wrote:
>
> The MAC address removal was checking if the hardware supports VMDq
> (I40E_FLAG_VMDQ) to decide whether to use pool-based removal.
> However, ethdev only populates mac_pool_sel[] when VMDq mode is actually
> configured. As a result, when VMDq is supported but not configured,
> mac_pool_sel is 0 and no MAC address gets removed.
>
> Fix by checking if VMDq mode is configured, matching the condition
> used by ethdev to manage mac_pool_sel[].
>
> Bugzilla ID: 2074
> Fixes: 774365884bb8 ("net/i40e: fix MAC address removal")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

AI review raises a concern that dev_conf is the requested
configuration and proposes to rely on mac_pool_sel[index] == 0.
This should be safe since i40e max mac_addrs count is 64 but maybe
worth adding a build check here.

Bruce, wdyt?


-- 
David Marchand

