Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F870CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:04:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0862C402AE;
	Tue, 14 Oct 2025 16:04:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 69F6740288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 16:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760450639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S5yv4D9aawHPxtgmUFvZfgOefCIiP5F0eCFFvYgagg=;
 b=CSQV26XmmF4qDICaXlDXkAT5+t+HEVs3pandkXjWfhwbLnySBeZfZzhHgkmJm8tfoCds2s
 VV4PFQgyQFDhYvjYfwhacMnsPWWI+Ulq3uqxHt0VriE61WnbkjFfgV6ZFpMag0d4N+i6pi
 zSx5s9J5uDpeAAefG0Eik/z4ZEbduKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-Kqo6hQ2SMYCfL9WznKytcA-1; Tue, 14 Oct 2025 10:03:57 -0400
X-MC-Unique: Kqo6hQ2SMYCfL9WznKytcA-1
X-Mimecast-MFC-AGG-ID: Kqo6hQ2SMYCfL9WznKytcA_1760450636
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e2c11b94cso40305645e9.3
 for <dev@dpdk.org>; Tue, 14 Oct 2025 07:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760450636; x=1761055436;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8S5yv4D9aawHPxtgmUFvZfgOefCIiP5F0eCFFvYgagg=;
 b=IKIsQt5oc+7i74eg9LUlXV8uT3qXDR76HvCDstrwM1BbPYK+lUux6WZmlq1KgassEp
 NlSu0C0ikdPiXc6tKTXACpM49ROUp/ztfsGz+yBKtv7fu5J2wi7ll8fTwo/Vqyd2LvBG
 /1qhQ99+LiA8qfZwPndSg7pJbS4qNdmtUiw4+ZIgv2zWbXK1Qv0YdDtXL7wQ6sHyhmSy
 VNGtgiSdB9YWGdr9jCqR32oLtm5KdR/t9etfRR2q+t5PK2yq2cJGKsWaXRSSfKnTPUc3
 g8juayilKo8IFpaHLC9yTFMe8nGDaYjcTjW4Z1e8wg4SknN/XlD+Mn+DnVvUQtXDXCWR
 ZopQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWv10eYvy18wp0D5Eutx/r7QSv0qR5rHRaKr/ODAqAjXMDtXALTmMGb9/7M23Kf8l2qJ4=@dpdk.org
X-Gm-Message-State: AOJu0Yz5dHTjY4wUst+TxW+QeFJFDPRqw50QwNloq8vefMUrOJkoXEkx
 L0ROfLdbqFh14i2/QO3cKpP2Ub0HTSjUC4f+5HpyvPo7qnitTSmQz2ZxrW9dEcbl/l7R7T4HmeY
 l+aPlE+dwdL6vvMVzgTzOb9CHa4eliHbvopXpSRG2BqDX
X-Gm-Gg: ASbGnctjDj7U7RLtN1hGkN1ozkj/Jgj15cbsD/VWwrjooAiTdhq53Se8xM/m/PU4fW2
 KiBgBq4Xp3D32oBP7QylBS4r2uZXgb6PLArU7cg7+OzqP34vhsGbU2egXaxNyDIVz3f7Ludi3ih
 08wI3zNKASFMrKezuGngQEOK0JEqQLt5ya6t0iqGm1P4AvgcZHj645Ff4JO615p8IFV6j52S4LJ
 melWn7R9Hd0jOzeD+xZIHUHg+9xotCimJQO71hfVqPMh+JijpNDUlRIuvqXx1vc+LxkrAXmBhHQ
 IosDjZuoZmU86AwX0K05RTnia55V9GH5uyw+A8XkAaWk36ppzAVndNUPxCw/AAHcBctXbsRRi5X
 i5R1ZIZkbJOe/SENKdWIbhGU=
X-Received: by 2002:a05:600c:1990:b0:46e:37af:f90e with SMTP id
 5b1f17b1804b1-46fa9a8f085mr173518785e9.6.1760450636009; 
 Tue, 14 Oct 2025 07:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIyBn/8yMQiK7LX5N08QwO72J3T4zBqjAh/n3QBraE1g9GuqI0AicdR2zf7iwf6GsQt/gL+w==
X-Received: by 2002:a05:600c:1990:b0:46e:37af:f90e with SMTP id
 5b1f17b1804b1-46fa9a8f085mr173514895e9.6.1760450631339; 
 Tue, 14 Oct 2025 07:03:51 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583335sm23335128f8f.18.2025.10.14.07.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 07:03:50 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 14 Oct 2025 16:03:49 +0200
Message-Id: <DDI3NYJQ09UI.1ICX3S2X4K59S@redhat.com>
Cc: <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>,
 <stephen@networkplumber.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH v6 7/7] usertools/mbuf: parse mbuf history dump
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
 <20251014124046.1032293-8-thomas@monjalon.net>
In-Reply-To: <20251014124046.1032293-8-thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WBrQIND5mGJ4E_zF70Y5tS-K5aHE2Madf3wGCe26hrw_1760450636
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Thomas Monjalon, Oct 14, 2025 at 14:33:
> From: Shani Peretz <shperetz@nvidia.com>
>
> Add a Python script that parses the history dump of mbufs
> generated by rte_mbuf_history_dump() and related functions,
> and presents it in a human-readable format.
>
> If an operation ID is repeated, such as in the case of a double free,
> it will be highlighted in red and listed at the end of the file.
>
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---

Acked-by: Robin Jarry <robin@jarry.cc>

