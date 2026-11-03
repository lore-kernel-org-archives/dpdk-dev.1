Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C274606EE90
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcLo3Ib+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3BCA42795;
	Tue,  3 Nov 2026 17:16:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 0ACA94066C
 for <dev@dpdk.org>; Tue,  3 Nov 2026 17:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793722617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fp+Ogfg0AMFFw7s+V1lNXPPFHmFr7+mA3WzXUWZRges=;
 b=hcLo3Ib+nea1jHSaeWr0j/sq/B7GuqRULlIxgp3Xfb2kErkWPoCnEuavqeTCob6tTVp0F3
 HADOsTNvtXl9o00qVdBcYm8jyhq+ILLwdnrfZ2P90/+5QeeBTcaKGEGaUBpN/slMciLdxK
 cFMdqPdzv+8h3YMNtNbaSIXUMcQfiWg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-ESXhLKkoPwWsFqzKbBAFpA-1; Tue, 03 Nov 2026 11:16:56 -0500
X-MC-Unique: ESXhLKkoPwWsFqzKbBAFpA-1
X-Mimecast-MFC-AGG-ID: ESXhLKkoPwWsFqzKbBAFpA_1793722615
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1fdde384cso31685805e9.3
 for <dev@dpdk.org>; Tue, 03 Nov 2026 08:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722615; x=1794327415;
 h=content-type:mime-version:user-agent:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fp+Ogfg0AMFFw7s+V1lNXPPFHmFr7+mA3WzXUWZRges=;
 b=ZR7IV/KwfYnmSDYiFVdRBVqqcveacI/X7p2M7krznhqvZmYfZniBcJjkqJiL02rcmt
 tzF+WkNapOTMVKsXMUDHd1ObEQUr8O9/ZdQeic27BFq/yTMoYOqgoNeKZSqVCa3tryWO
 Gu+uelZTALU79lgsW/fxNYIOmzVHn3aFUeRJVuyHoLufINb5QPCIcpeTz+FV1zNzD0Nu
 T/G3FwxIOOuQXT7OqeIELf3nQNueWziUUtHuiJenqqV9XaWayIE6JoFEcSJJUk0ztWEl
 MgaH5lmipd5zzgftW3YgyS0A0Yz7Ez9RTTyoLeJG4e69AS7qkKRfScz5Z7bakLRKO6fy
 ghow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgkhEPYNWStzOmXppRelWahVw5hZpDFiMXaStzNaGPjURoTV19crw45i/lYtYnl0M6RiQ=@dpdk.org
X-Gm-Message-State: APuU4Z82sZqphrrao29pWOX1no1Oo2ZZqkkDSmMD0cXFve5VQn8YwvYL
 2aMc4cugBNkimltKvAPB/ZtBZPFoj5uOtIyfudhl2qlgEbfWESAib5UOwt9Dx2xySX8BNk5DG9Z
 kvOLdMpbXlgzrKtUuHQiqF5m3etqnLyQM5qjYeO2LkF5B
X-Gm-Gg: AYBFou3CfQTq1iyHSjvFbr0tHVaJcioY5xNfeajGDgS8mW3gBzrdSIJRrofCVxCIvMd
 3SVzpQ5VR7VcSx9SUsc5bMzlWEK3DUYQULo5aUvEm0/Pzlep24+EKPsvK9L8ATnFwTTSWPqc0Jt
 B8xgwZ0K+WqyX0vSwgvdAqVi7ROPh7TVHKvP023TipaiH0rpOGyxVoNAbYDQV9+SR88ayy68DGQ
 APE75+VwSRWs7HO70xy2NXxfDgTHWVMetI4gLUxF/RU/7XS5Wj/MUCLEuHe9nDfwXVbv/XAYxIg
 2aiVM4PXgfCXhT2cVHq3Q9pzcEBnB3tdH7QliyoHC6S5ibhV0p+nWExTf1d0EsoqKp3Fdvd+SyK
 GqaginVATiqPe97mMEVS73B71DvzXICEwTJXxiatv+Ep1gZoydkr8Zbu60SiilsRFVFixRgXHiZ
 Rg
X-Received: by 2002:a05:600c:1c0f:b0:4a1:ac66:6059 with SMTP id
 5b1f17b1804b1-4ac19233381mr306429495e9.26.1793722615203; 
 Tue, 03 Nov 2026 08:16:55 -0800 (PST)
X-Received: by 2002:a05:600c:1c0f:b0:4a1:ac66:6059 with SMTP id
 5b1f17b1804b1-4ac19233381mr306427795e9.26.1793722614108; 
 Tue, 03 Nov 2026 08:16:54 -0800 (PST)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([153.92.90.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a93232f0sm69683305e9.10.2026.11.03.08.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:16:53 -0800 (PST)
From: Aaron Conole <aconole@redhat.com>
To: Chengwen Feng <chengwen.feng@linux.dev>
Cc: thomas@monjalon.net,  konstantin.v.ananyev@yandex.ru,  dev@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>, ci@dpdk.org
Subject: Re: [PATCH 000/227] use NUMA node terminology across the tree
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev> (Chengwen
 Feng's message of "Tue, 3 Nov 2026 22:49:18 +0800")
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
Date: Tue, 03 Nov 2026 11:16:52 -0500
Message-ID: <f7t7bitkhzf.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rz-nrxPOjeRj34m_rY7yivoXk3R54iKLzQ-8VTz1BoY_1793722615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Chengwen Feng <chengwen.feng@linux.dev> writes:

> From: Chengwen Feng <fengchengwen@huawei.com>
>
> The DPDK tree conflates CPU sockets with NUMA memory nodes: public
> APIs, structure fields and macros are named after "socket" although
> they actually identify a NUMA node (e.g. rte_socket_id(), the
> socket_id field of rte_memzone, SOCKET_ID_ANY). This naming misleads
> application developers and pollutes vendor code that targets NUMA
> topologies.
>
> This series renames the terminology tree-wide:

Do not do this again.

I have set the robot from considering patches from you for the next 227
hours.  One for each hour that a patch-by-patch test would take.  Do not
repost this series again and expect the github robot to run for it.
Please work with existing maintainers to come up with a plan for each
area rename.

CI resources are shared, and in the case of the github robot, they are
shared among OVS, OVN, and DPDK.  Additionally, a 227 patch series is
completely unreviewable, and completely inconsiderate of reviewers time.
Anything above 15 patches is, truly - who can keep that much details in
mind.

