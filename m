Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5427C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 21:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F34CC4021F;
	Thu, 26 Jun 2025 23:41:56 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id DA3FC400D5
 for <dev@dpdk.org>; Thu, 26 Jun 2025 23:41:54 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2366e5e4dbaso24813865ad.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750974114;
 x=1751578914; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2Lx279VCrnSomP22DrcECHW9ED2XA6I2F2OhGQbicc=;
 b=epABJ94fynzUQnU07br3Ln/771Zhs3oVgllEPbT0e280GuWM7qfKGUyg2PtowmqXq3
 A2T2vaONq++dPk+Rib/8+FnPJ9aXcwLmjqNjFmk5RdSuhzmKCCfuqvvW3P7U3q+8SkuI
 d+ge17OEWMODQv7Aby8IVqIuZc6odZig+RkI0vIIXP4qwjjbyDV6SjTf+JbGQrcJ+8sV
 GUgPApG+S8FIOUv9ND17tS0lZea8Qq0xkKtTG8RKhcuGxkAGmJPgvN5XgGkLVubIb3By
 ttca9N54pUsH9iGDPg3lJqnsiH9TAkp9PjwGCiGedcmrfZWJVTkKhyH6/jnytBAEEuPR
 CA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750974114; x=1751578914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2Lx279VCrnSomP22DrcECHW9ED2XA6I2F2OhGQbicc=;
 b=qHe0t7Y4drK8eBGuDbv8JGRDa6ypaeqj+9mArsh7w5+FBbyqPBDvhwZeM+O/zgZo4q
 YaZ5fdGWJ0LXER2PaY0aP+sUB/tmnNrXG1lSRg3p5czed9dAsn3qpyFtp95y3Vn78ndh
 NYj8h+D2TNjdq7BHPPOUU7LwlhXVHWq9lwTfr8zT+P3yZ03nJqULGlJwny6mUB+9sRV9
 EUet1wGth4kMHhOH8J4kAbgZLelBZdYpwIiDiWJmBcecm9hzLtlt5qGu28ZZKvfvtHLE
 T4MTlumqewWK0GbfIICHP5C29qJiqPj5+NgIlAadPXishsmP2vpOw4yUonWEsRlh6cMO
 2I5g==
X-Gm-Message-State: AOJu0YxO5KgUCu39GoU6sg+bi6+9IlhW4j0Z9Slyn/CJXw3OSGqa58Nd
 qXfnpLP93uCca3yVMVZJfO9GucqDGd0XTUosm4SNLZqs348fglprJghngtC7C86SVeo=
X-Gm-Gg: ASbGncv9NiCWPjfBDsKl7YkiYpsuHetMdAPbxf2WloERPbHETvxNpKcUOYOKPDEhLzY
 S3WP3EDfKhS50uLvL296s0R41+8cpGMbeL3wjkwM6xf7eJk8GIypnYSw4+MuMus+F1+JpzEcEZj
 S3hZocdJIY4ATfgMGcmvAQTunpsYXVeTzKiesI/v304LVFzd2mXXUAY5YjZp7CVYDZ/0iduJEuK
 CACzViUcucT8dqX448t+OGW+Kgp/VOqBftY9XjVonBwlTloCMVHo76EXOndpHULUEutbRzccsNp
 n+SxFp1jKYhXN832UIdWFbZ0iP3hkRnuulUrP899hjuTT+fGOFbel52JrsVD2DAQE6y9LxI86Gb
 rZa9SLzdc7kmORqVjqDIt3hmhw7hfKr6bXG/MwOk=
X-Google-Smtp-Source: AGHT+IGXCS1XfJBQUqc07wgzYBh9l/fuQtMmAHZUboIHdPNLgnb4y9ilkxkET9w0TtXfUITuDy1Xkw==
X-Received: by 2002:a17:903:807:b0:234:1e11:95a3 with SMTP id
 d9443c01a7336-2390a4a8832mr59027915ad.13.1750974113903; 
 Thu, 26 Jun 2025 14:41:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c39c7sm311885ad.210.2025.06.26.14.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 14:41:53 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:41:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Yi Chen
 <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>
Subject: Re: [RFC 14/18] net/hinic3: add Rx/Tx functions
Message-ID: <20250626144151.05cc2708@hermes.local>
In-Reply-To: <20250418090621.9638-15-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-15-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:06:00 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Feifei Wang <wangfeifei40@huawei.com>
> 
> This patch add package sending and receiving function codes.
> 
> Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
> Signed-off-by: Yi Chen <chenyi221@huawei.com>
> Reviewed-by: Xin Wang <wangxin679@h-partners.com>
> ---

If your driver doesn't implement these call backs, then leave them
as NULL. That way application will get correct error.

> static uint32_t
> hinic3_dev_rx_queue_count(__rte_unused void *rx_queue)
> {
> 	return 0;
> }
> 
> static int
> hinic3_dev_rx_descriptor_status(__rte_unused void *rx_queue,
> 				__rte_unused uint16_t offset)
> {
> 	return 0;
> }
> 
> static int
> hinic3_dev_tx_descriptor_status(__rte_unused void *tx_queue,
> 				__rte_unused uint16_t offset)
> {
> 	return 0;
> }

There are several more bogus stubs such as ptype support etc.
