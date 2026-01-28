Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0027AD35663
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 01:35:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09A22400D7;
	Wed, 28 Jan 2026 02:35:24 +0100 (CET)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43]) by mails.dpdk.org (Postfix) with ESMTP id 86F24400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 02:35:22 +0100 (CET)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-947fef8ebf4so245825241.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:35:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769564122; cv=none;
 d=google.com; s=arc-20240605;
 b=H/JhwUi9ydtvRm3lb86FoXq1H1W2uIB9LRGA9YuYx5unljHOWzPaIjamho7aE8fNwB
 /dExwFPG+TOfyiCJtP6Dm5dC7BXtFoyB1g9ZQ0N/AkXZdLa5NCDRxLMPA3Y2toIrzvlF
 ZudsmtQ7Tx8WGvBx56w7XDtBMIX2n+XAMwwJDNGk6/raAgA/X8BI/khxBYJsVms2+IeI
 r6TxiaO8FobIRMF7kFirpbp5cxC9opPidhoY9h8X1TM74tCokpWRc/v2x3Q8/RA10fga
 6wxb269AAne5FILPYXfRL+M5X3oVyZIlm+xWNVwGXxc4TzFbxBRI/S0rTR19J3cjX6kI
 zCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yxi4yu/YO3GkPSujNXT2PEH03Z8UE6gLnyiomBwRl2U=;
 fh=1c4TJrSHP01pKxi6GucbcO4vteuKi1v4GQTIV17P9es=;
 b=GhZPn9ESJMKQcdC5wVmy7PVbFg019whXyxd7Wh2STL/jh84j/VsXfK/IgcMvslyV++
 NUaKEm0rAnUn/YYlVyDWFfG7EDtV4bOyYSAvPV0v7vXitxvgWJRDyM/UsoCwyU3Pn92y
 S9HgOIiudIAL0H857fHgRgIBcBfArHro0aYXJaX3tJPCu8/DmhmNWscoN8Wj4muA7/Eq
 3aYqXp43TOGZqJffL96GEH3m3oM+v1umSQyeVm/j9kNtp7GhWbzg995fBTEzDW0us4ET
 T473qvaY66p+YuQ6jubywLVU4IntAbayEv6TagLs5wvuTkcEjajZqOEnRT95F09RLn9Q
 PHvA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769564122; x=1770168922; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yxi4yu/YO3GkPSujNXT2PEH03Z8UE6gLnyiomBwRl2U=;
 b=IuDL+4Lo7ytnCh6mU/dIph5LnlErkVrkYDEE2KGWblo12EUrMAtqiXBdBUgNuie7Nl
 8Q2rzX8PmfTfZ8wR4peEVXzYV9+o5a7DcSTZmNkcI9cW11OF2QG+x6HBYUccUAlAEVAJ
 TJshFI4ZlOU6Npe4j9Q0lsHqQ8ogw+AJKe19prjer5wbGq3a7PwbaA7VD6EdHMy/mDBQ
 4gbJCsST/PTMWqDOqt+EXe1WBkocHQOuhoG8l7UosHY7fLzZp5XxDr2kXCaYH4+R2E30
 /i7WPS/n9OaxKISgxQER6Dm9vhk5mJH8GjNvSoAwHxMpMDI6yJLIgh8E+JkJn3i6Cdf3
 KUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769564122; x=1770168922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yxi4yu/YO3GkPSujNXT2PEH03Z8UE6gLnyiomBwRl2U=;
 b=PGphrXkwwy3c+7Mtl5t1990us4Fb2k4qxVvhdeYwyFE5LDDxx4ATEbnkxXm6vr7EmV
 caNlFg5qi34XpJe+u/yYNbavPBlmmj5YjevkS9uwj7UCcizWP6HBKjCC00ItxFo+IN1G
 txaL/DPxZR3ZBUImttJ1ScyBNuGsiXWXpsLkv4uqUtoeor3UMleYXFXyBTI7laqWoafm
 en94Ixm1YfOKgOiYVxnBk0bSzX2aYnx8Nv7n75/Q3obfGT+pkrnmLRmM2Rmhq09HzARB
 6yo6ngA/YrgyG6jo3IiOehxuRpwfdz6IOSZJPWSH4BpqcOJNYrDQl6BHfH2iZL7ZaXCb
 9a/w==
X-Gm-Message-State: AOJu0YzrZO1ZdR6k2oshOlRPmT2lIhsgRfwJp8gWw5va0nrx48V84A8I
 ZT7VxKENaN2LCTgT2j9qxgO7W1Sa9SlfZ9pYpNzDtSPX59OMg9ASLt3zGJhCJ1VSwH280Wu0oxN
 nHHwnIeIK/0PYy9Z2JqPzd0GlTk4jqZ3sqg==
X-Gm-Gg: AZuq6aKn8Gj5jEQGagyLPqT9/nDCnI+ZnogSrmHvyBj9HbMMM7kZtCnCKGh3TdH1BYs
 UchQL1TXwX/mg2XteIRYy4s0aY3FU81ad5ChCOQBwd8kZR9lUpBoFzKHWWVS3IiUPFSKGlvk5FJ
 pCvq3NtLNmDkLRJd9r+MX9UIT/ewRURK8nxq4LgQGLlQrWI4TWdDVA06lDDZISo6pdqvx1s0X68
 4w4lj+ShcJruLdKMh3W0VLT11aJd1P9YvbtXkE/HYumt7uQVRBjxNuvwlQ+a81J+FnLvN9KEg==
X-Received: by 2002:a05:6102:5092:b0:5df:abc1:e6b5 with SMTP id
 ada2fe7eead31-5f7238419bbmr1422033137.17.1769564121821; Tue, 27 Jan 2026
 17:35:21 -0800 (PST)
MIME-Version: 1.0
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-2-scott.k.mitch1@gmail.com>
 <20260127103911.0908b2b4@phoenix.local>
In-Reply-To: <20260127103911.0908b2b4@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 27 Jan 2026 17:35:10 -0800
X-Gm-Features: AZwV_QgsKuu8ZQoRt1YwcxGb70g-BGd4vznZLoQg8Ma4kv1QQyqog1-AyLXf2X8
Message-ID: <CAFn2buAARvejwOMBdhmRqi+vUsKRUGLSwNNx09UVW3UYeivbRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] net/af_packet: fix thread safety and frame
 calculations
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, linville@tuxdriver.com, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> This is bad idea
>
> Atomic is even more expensive and only one thread should be updating
> at a time. If you want to handle 32 bit platforms then something
> like the Linux kernel mechanism for stats is needed. It does:
>   - on 32 bit platforms does a multiple read look (like seqlock)
>   - on 64 bit platforms is just regular operations.

ack. I will revert atomic stats and keep the existing approach
(consistent with other eth drivers).
