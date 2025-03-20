Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA61EC28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 18:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE3C4065E;
	Thu, 20 Mar 2025 19:54:34 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 5400740662
 for <dev@dpdk.org>; Thu, 20 Mar 2025 19:54:32 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-224019ad9edso28755395ad.1
 for <dev@dpdk.org>; Thu, 20 Mar 2025 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742496871;
 x=1743101671; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMUXGbZQNTm+WIpYIzPVvc9XFXAV1Zxk8NxFLcSFLSk=;
 b=wgP5cT9+SH8VdyvzPzQTrQUkeDsAPh4tG10iLBKiy2D+QdfCEWCrwKKmMmB8BMN8X2
 oj6bdtcMXBTp/BYdMeiARb1j6fcHdSuUI1/GrrkhEc6mb+L+fAcnxvdBBwNDHXHdGBQr
 f5bFH2bxohklSQK2gEeDhkDZPut337vnQ94yMhDx4o4SMGnd2B7pqbSd7GjKSj80AN7A
 czQTWmrVAZmj0jWrlR1N6MJ7cnGRkhaqd+v0h62+PE3nbpBOKGlIiNHOV0PbnIWBMrzg
 qilopKLQ9QE3dNCSDEbyeRRNRJ22SVYDqBrx9INybgRg8foQeMqfle5oUJedfLSGyHK3
 KDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742496871; x=1743101671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMUXGbZQNTm+WIpYIzPVvc9XFXAV1Zxk8NxFLcSFLSk=;
 b=Mp/E5Rle9+oIuyncfDpo600UJJG2VIKvqE9OAMQWonndVyet1lCJS0Yj2xJ8IYAgWY
 l0zO+REWrnhflr67C/NCIivdPC8QUA41Ka73wA1yseDakM5olGg3EW14/0PduCLmPZUJ
 bz44zQyi8RL1Od/XEPmX92HOCFFYgtXO7vanJfOPqLeeZcJOG05fpvVMOerSppo7d3Rl
 JMaXLBZ7uN/v1pekCrY+GeLy5MgJbNPlb4RYLsYjYkBT/R0hWP1LQzOGSUhSnLh/Im6Q
 rvuq23ZQeg2Cy6WpZdc7vXQY4WK/Y0e5wMt2PNF0CAUL20qgUvWDuJm56KsGWM6RrvEA
 0bGw==
X-Gm-Message-State: AOJu0YxgOhjUX73FRp2+P/1tqlFuMn4Vtn4Ki7k3ZD64s6bXHTY6DlRO
 KhcS7bNFTjdl0ajgontUOz6yd/rLpk0AbGMH53v9YblehtQyqfkMRyeWRLKo0RKB0a5HDzi6dcx
 q
X-Gm-Gg: ASbGnct87qzZyJ4Mf1vaGGbfL8IGOsS7syEWC7prFCEwDGXggfrkyQVL3KzEpmK0jv1
 ADFEXb9c1fkOSVoo2iqAI2uzr+IUAOYeMaQ3fuzBbGduuT7K1uWeDkMjqsAOyk5YAdKk/pDlVoM
 Y7eXlduuYRe5QOseONkm09ugfFtfBsfx0sdC54viOamifteuEPG6ZYICKzUwoDdopvq1TYnw+Y3
 INw2wo2L70Jjp96ypvD1t7TMvfEQV3NsyAtI+5lgx+u73AiR5xsFz3WlS1VCac9E8rc7L2z3BtR
 2LNrwpVeclB9wX4o8ymHo4m5XAaagHQk6P7CYr0FNKW7PBukAqx/3HsNDExn2g+3YZuIjGIw/W9
 iK6uhTiPyDz/Nx21VNxvEVA==
X-Google-Smtp-Source: AGHT+IEM3Vqos170EMk2kgAGEgOQd74mptvvpYPJ3T5doaSVn6tJA+f4nBIuMfcNVlFT/9cd2uiFBg==
X-Received: by 2002:a17:902:e5c6:b0:215:a179:14ca with SMTP id
 d9443c01a7336-22780c508bbmr7229925ad.2.1742496871402; 
 Thu, 20 Mar 2025 11:54:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f65casm1266985ad.230.2025.03.20.11.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 11:54:31 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:52:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 1/3] net/macb: add new driver
Message-ID: <20250320115242.58ce3e9c@hermes.local>
In-Reply-To: <1733472394-314367-1-git-send-email-liwencheng@phytium.com.cn>
References: <1731310932-1743343-1-git-send-email-liwencheng@phytium.com.cn>
 <1733472394-314367-1-git-send-email-liwencheng@phytium.com.cn>
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

On Fri,  6 Dec 2024 08:06:34 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> diff --git a/doc/guides/rel_notes/release_24_11.rst b/doc/guides/rel_notes/release_24_11.rst
> index 8486cd9..962291a 100644
> --- a/doc/guides/rel_notes/release_24_11.rst
> +++ b/doc/guides/rel_notes/release_24_11.rst
> @@ -167,6 +167,11 @@ New Features
>    Added a new network PMD which supports Realtek 2.5 and 5 Gigabit
>    Ethernet NICs.
>  
> +* **Added Phytium macb net driver.**
> +
> +  Added a new network PMD which supports Phytium 1 and 10 Gigabit
> +  Ethernet NICs.
> +
>  * **Added ZTE zxdh net driver [EXPERIMENTAL].**
>  
>    Added ethdev driver support for the zxdh NX Series Ethernet Controller.

Needs rebase and please target 25.07 release.
