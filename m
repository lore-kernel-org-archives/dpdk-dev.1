Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C51CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 16:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1040402CB;
	Wed, 10 Sep 2025 18:03:31 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 82654402C2
 for <dev@dpdk.org>; Wed, 10 Sep 2025 18:03:30 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-729c10746edso55578146d6.3
 for <dev@dpdk.org>; Wed, 10 Sep 2025 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757520210;
 x=1758125010; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3x0NKs/Je4TR0Bo0/lPE6WVwsuDS6iguWbfvpcH6CrY=;
 b=WkeAEKkXpm6GiR+tP70CgVVwhPEH5LPtMKPVDz7xrjyZn9THVdbZIr7BtyZK3Q/Cdb
 Bz6XXeLjt/Uijknb33RE4iA8N7Ijn8ApL8owTTvTkh08p5tyKnoImWE1/m7FtoJI8cde
 ++gU5pKPSE6AHvkWPJzTK3R/KsiCxf1zr8Y1oDnxEFk/6i+4HBt3EC4gW8uT2BptvqYT
 Oqs8jCoDM9TTzDcmjtH6/qdgt4e+ZZSAl0aKiEAs6ocMx6IBYidcBT0yA5rzGukzVm9Z
 ZDnvPpBYzqfc8zbHTVPUNjik/jrJlV8pgDTdkVjmjlw+KxolJrcoPKyMdIxysQd2fzJY
 ct/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757520210; x=1758125010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3x0NKs/Je4TR0Bo0/lPE6WVwsuDS6iguWbfvpcH6CrY=;
 b=AvXSjdNk3VCyPEqcyGjUTiy4m0JFykQDDr5igaC3Qr8i8PN/hn6H3dzKizWfLwIPkc
 Kqre01IANCioxGTS7Em+rkVLeo01+sAWorcwR7cQPYybsV3NP1BEeL6VsEalS7Yswmwp
 Dtd3Q6zUa312f4+OIGpTxFMwDEZrsHPed2jOlRmfEyYUp3fbqIiUNep5ZTciDBtaF8rs
 HvDYZEEtRNVbLsEf8vxkFcLiJa/BfSdk6cXs8Pejn9VdEatV4kSOZYY32yb+7XPWC94G
 88wXjybxmPDQxIPeEO1Bs3QJXQZBvHH6PaO6yixJUA5EO/KXm2ue2uM2jj0k1afmhGTt
 MNPg==
X-Gm-Message-State: AOJu0YxWxGz10Q1uoRLW6Op6KJedMzv27su5sm9Ko5z7Adgi0cHaaJp9
 CKu+9yYxytkmidS3h7s1+mAe0LMvS+WZcYHwif+aqwPLrjiIFslEBkNwXGY8hT14/vo=
X-Gm-Gg: ASbGncvP62P5nfv0QdpZDIrt0tpZkrH9gT49w8MsuzstFVMSA9ys7LAWdgAgMX7K7yZ
 wQTnG4DXyiZGIQbH6lQzf/qgBNxfnlQqv6i2isIIuKHHF8QchBuy5KgFUbzJzVw0K8Pxi74y9vq
 JooR+eKnRKUlgGMRDxmmechjwou7fcBsPM9ESMYkd/JupEncDhD2J9rJiZR9zjbcX2UN9IsaJgp
 5NWL4GAqZgq+JlOzZljrTapIyYsCdik41SsOZWGoqarDivBhk/kbZdfdTWpcvXVtm05y9ucebZy
 nDZtqMMbSD9Z2gIke9LBLQ3B7aT8xjPKUUmnW+Ng10l/x4L0Uf6I6WINPejaWcAYv+aNVcg+Tyd
 EzJpKoW0gXmORmxEja/wGLN0Dadl6JE/NPuofNNRZCagIrmsjqf/JnI5KVGVMzKEp6OYoMO6MvQ
 g3yA2m4RVpqrWQpi6FHbTS
X-Google-Smtp-Source: AGHT+IFyXGAGL07M48Lma/7fsBfOk1qkSz09C2+DyoiPIsXl/01fw1MRiW9Ra73XkRVhB6EOaLLCRw==
X-Received: by 2002:ad4:594b:0:b0:756:12e2:8c50 with SMTP id
 6a1803df08f44-75612e28c78mr74729676d6.15.1757520207614; 
 Wed, 10 Sep 2025 09:03:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-72aea5d8d61sm118010776d6.56.2025.09.10.09.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:03:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:03:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: huangdengdui <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
Subject: Re: [PATCH 2/3] net/hns3: fix unrelease VLAN resource when init fail
Message-ID: <20250910090322.263689bf@hermes.local>
In-Reply-To: <7c8afba1-feb3-4150-8e4e-60655a0c7191@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250813073317.1352274-3-huangdengdui@huawei.com>
 <20250813075138.0440576f@hermes.local>
 <7c8afba1-feb3-4150-8e4e-60655a0c7191@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 21 Aug 2025 20:16:25 +0800
huangdengdui <huangdengdui@huawei.com> wrote:

> On 2025/8/13 22:51, Stephen Hemminger wrote:
> > On Wed, 13 Aug 2025 15:33:16 +0800
> > Dengdui Huang <huangdengdui@huawei.com> wrote:
> >   
> >> +static void
> >> +hns3_uninit_hardware(struct hns3_hw *hw)
> >> +{
> >> +	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
> >> +
> >> +	(void)hns3_uninit_umv_space(hw);  
> > 
> > Overall, the patch looks good. But why the (void) cast here.
> > The compiler allows ignoring return value unless the must check attribute is set.  
> 
> Our internal coding standards require that when we do not check the return value of a function,
> we use `(void)` to indicate that we have thoroughly considered that it is unnecessary to handle the return value here.

Having a close or uninit function return an error code is rarely useful.
The application is left with "what now scenario".

This style goes back to 90's BSD style. Probably when your coding standards were written..

PS: if you want to force checking of return value, there are attributes for that.

