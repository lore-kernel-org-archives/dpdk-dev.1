Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA19CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 04:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1630E40647;
	Fri, 26 Sep 2025 06:54:43 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0F7F940647
 for <dev@dpdk.org>; Fri, 26 Sep 2025 06:54:40 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-86278558d6fso1764985a.1
 for <dev@dpdk.org>; Thu, 25 Sep 2025 21:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758862480;
 x=1759467280; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8a8eK7KkjPAPY3eM/8czfvEwXkKitRkxhy3oALBBdtM=;
 b=t+SY9unh2qeCL6tSOLrGaJ/7BYewuPIn2U8FnoJPnmabBWUg05yofNQB5zhgSb/WmA
 WpLh+DGuUfG4eI77HqXFok80lm0FcdYOGzZqhDtavuEzIcO/KqI+hfLlTGl6WYvmvVjT
 b2q1chwAqCJssEjU94B5n728XjGHw5wLoWMKsUPLktHMKozwvuycBpIstB9q5eFZwixh
 rfdGgGiZdkZXD9ZFq7QM+y5PH64dI7PHqXKuUo/oNp2PIGC44GsXQzan//NJLSgPXDP3
 rFmjG/Zj1hAZm8RzJ+Umxvefjxh3VckfTG3Mz5uhX7Dg71Nw7JwapdlwrdvW3ek0kBKe
 xIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758862480; x=1759467280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8a8eK7KkjPAPY3eM/8czfvEwXkKitRkxhy3oALBBdtM=;
 b=eKLfOmemSC2xM5/ItkBRLeq8AMzS3U6m6j7PZQ3L71JJJjLgDbPDctAVdLTMptTOHW
 1P+rM/ypaqTxVX6BVAlHZBjFFQzc7Wx4CNqENiCkHvV+ZaJ2POM4OTqUMqQn2M+S8AqJ
 MHWxr9IzvCjoY/ohVmfNaspM4zQRr80yVz+LSrepzSTAZxvHgVWl3PZqlGxNo8IbHZWq
 PoyTwPdU+zVjibQc2xKcB2ZXi8aI/3JEnl4xuj/h5EPYxgGutE4P09poluXUvGRNx811
 6mcih3+W7BbKNZ835UYR+JfrWhmVGfnEjObHZlz0+w+fygBPnvzjbxqQjgrRCdux0tiQ
 UqxQ==
X-Gm-Message-State: AOJu0YzrMhZrjk98Qe00uIxokUGhss2hHISW1OullHGn1RjvET8SEzFa
 noLe31tcuwzL3f3d9462NKlDuBKkjbvDrqg2C3rUmLPovLmoAppgzl2ooye5RnMt2UA=
X-Gm-Gg: ASbGncvnV3F10JD5Tg6A2TNj6LnnjyEHSDyaE19rol+NOmy7S+UPcTSGjDO/e1yh3eX
 XMuS5sqU+YK2YZI5gxc+QYsYHX+Gb1JO5vwDfyUaOWiPCKi5w9ocolvETtadehJIII3nh23uons
 K+dXPuq2IcbiyRlWTQdwJWQ5kzA1QBg4Jml8R4YfTN1cQDOtRu6wlpuhPZNY+/Bx7lQjiUQXquo
 luD/4ZDyKqZeF+5WjRLVs0sxFOcVn9+lZe5+XiE/XnZZ2lZ5mWKLk5tHObAIF9UvpPLp2n4/aR+
 5L1kVTzoYy3Fu2gqNtn/++srWADNX21rMbbO2rd70AjL8zHBhIY0wO4NrYUzWhl471qCQtrCdbl
 6X3ePWTt7WimTNhvFkXL0CnwN3tD7IN8Rd1vqt0roEdXvDS0DwTAhxtQYuOf+r5mWoAcmU2F+dI
 k=
X-Google-Smtp-Source: AGHT+IEzPUZn8J8Z7iG/U20gdWT6QFWsH+Zh+7QMezAGsih0Fm/llgGpgYc8O5qvvpA8AiWAjJ32ow==
X-Received: by 2002:a05:622a:489:b0:4cd:601e:9d29 with SMTP id
 d75a77b69052e-4da47354f60mr75505031cf.11.1758862480219; 
 Thu, 25 Sep 2025 21:54:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db11ae8d47sm20561811cf.44.2025.09.25.21.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 21:54:40 -0700 (PDT)
Date: Thu, 25 Sep 2025 21:46:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, gongfan1@huawei.com
Subject: Re: [V14 00/18] add-hinic3-PMD-driver
Message-ID: <20250925214622.3606e2aa@hermes.local>
In-Reply-To: <20250926024747.1314-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250926024747.1314-1-wff_light@vip.163.com>
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

On Fri, 26 Sep 2025 10:47:16 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.


Updated the version queued in next-net.
