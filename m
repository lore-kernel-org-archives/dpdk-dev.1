Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F4CFD313
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 16:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D884A4067E;
	Mon, 24 Nov 2025 17:14:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 29380402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 17:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764000843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFXTISBeKshUPzQRU1jwj35fm0J0wzqWAyLxuU5bmLI=;
 b=aLuvFiH+Wp0pAmIM933k6bR3hzq3apDIsvSWrXp+Z59AzqQQIQpkQx0Kf6yfhBF1r+kJk3
 oaQuCn2o5QT1SoUe28bAaBKcvHkkh/3mX13d8l5T+qXXmXEvHWV4w7K+gvXXUuhUo8tktF
 kuEY56+L3r3KmMiEKJ68/COCXI+T+VU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-HYICy4xiN0eG91WmZUkdRQ-1; Mon, 24 Nov 2025 11:13:58 -0500
X-MC-Unique: HYICy4xiN0eG91WmZUkdRQ-1
X-Mimecast-MFC-AGG-ID: HYICy4xiN0eG91WmZUkdRQ_1764000837
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-594302e1f44so3799845e87.2
 for <dev@dpdk.org>; Mon, 24 Nov 2025 08:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764000837; x=1764605637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFXTISBeKshUPzQRU1jwj35fm0J0wzqWAyLxuU5bmLI=;
 b=q4eZUdR+LO5xK9cTr32dBHXVO23ToWiykTTY+mm36+lqcrw+XuIgBsj3YAi4M+dyKe
 N/pWlguifRzjVs40grqzUPaceuysEx3hSJs1389UElvJUAV8fDo9tmgqHqebvDpe+7wU
 81wc9Tx1uILTLUCW/G3YQW0ahrATXCUaPRRTcJK42D0qHumW+8S3aOKuBtQUZ7ygE/J/
 PUkxQZLSGSqU8tjQo+57JQ7ylNqG9mP6VsSDBGkum15HxXQRtsasUdN37XGFXSanc73t
 zmGnWUcFYzqsh9pNquhd640x/RdDSo9iiiSLoIMGcXQRmI/V9p/fe/7RsV0cm+nEX4u4
 vAZQ==
X-Gm-Message-State: AOJu0Yz3bKPhqbu1aCBCbDW8c2X4jb/E/48D++aS/IhdIkrt65puriPE
 mIzK20CnEmPEPKyojOKGD5iQeMuwxR/T5paxLYhp+yyVdXKxL4/uRWfKu3XjwT3BRFuDQhc83aD
 QzmLHI02D6ER8TZleblYGeLTv2jOA9BH+P11Uyc5C+reY9Ar0EOcOH6U3Syi+zlJB4/6oDiH7qB
 3GdLE9RCiDYFhcxyjgnKA=
X-Gm-Gg: ASbGncuBDaPyJ9lOJKzXRie8KTkIR1+8uVsu/JEuw9LSN/xm5XTmaUosdN3KFyTcGCE
 N9tQKO2uTO9xYRmobKFCF4bPeVculkCm6VwqhMlGr1yn8aH3tnliHkU8aFJ1bUsCc8HEQp0mc/e
 3X5pZVai/H0M/vI9BnPxweqYzF8nJf/fjC8NPTVeSccpGaHm/Fd9M+1w1WCnIpB16KzQAk
X-Received: by 2002:a05:6512:131d:b0:595:81e5:7556 with SMTP id
 2adb3069b0e04-596a3e9fe46mr4540154e87.3.1764000837186; 
 Mon, 24 Nov 2025 08:13:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFFccMi6kiolimo3QgUTKT52lIDqTAg1kIFnN6f5cM0CfZrlqjU1ChS9Cd5Bl3iWy+9ck54Z7SYlc/Rf9a9o8=
X-Received: by 2002:a05:6512:131d:b0:595:81e5:7556 with SMTP id
 2adb3069b0e04-596a3e9fe46mr4540137e87.3.1764000836783; Mon, 24 Nov 2025
 08:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20250827013106.2453922-1-huangdengdui@huawei.com>
In-Reply-To: <20250827013106.2453922-1-huangdengdui@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Nov 2025 17:13:44 +0100
X-Gm-Features: AWmQ_bkeeAIkIGFY3rnMccyYRTzhKQZToSyNkJZ6HlUsLimKnYv_lkt_aY_SNcU
Message-ID: <CAJFAV8zaqUETy_ZWD=S8XEWDZqGcLf9UOTxhOoJLcOCxk-uUwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] examples/l3fwd: support specify link speed
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, anatoly.burakov@intel.com, 
 david.hunt@intel.com, sivaprasad.tummala@amd.com, huisong@huawei.com, 
 fengchengwen@huawei.com, liuyonglong@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T-3N4UQgnUoDvpsbt2n4vSSFOzHg0wEbqphBOyeZIPA_1764000837
X-Mimecast-Originator: redhat.com
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

On Wed, 27 Aug 2025 at 03:31, Dengdui Huang <huangdengdui@huawei.com> wrote:
>
> Currently, l3fwd starts in auto-negotiation mode, but it may fail to
> link up when auto-negotiation is not supported. Therefore, it is
> necessary to support starting with a specified speed for port.
>
> Additionally, this patch does not support changing the duplex mode.
> So speeds like 10M, 100M are not configurable using this method.
>
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

Series applied, thanks.


-- 
David Marchand

