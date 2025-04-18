Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A06C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:18:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B360402E2;
	Fri, 18 Apr 2025 20:18:35 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 31715402D3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:18:34 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso2140803b3a.1
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745000313;
 x=1745605113; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWOnkhekMEQCtny4NUhBNV9MyF58GlI8rqf9FkSByFg=;
 b=lhZXIdLgWCUGPFzo19woGy4oDw7Cd3RSOfeXnXsxMuGKXgBJw4mIfGDhnch7spzlZq
 O/VIWLfrHxhNEetRXvOamqRsiwNdXShSRHH6WxXrZNe4Lesb79fbUyWiMTqSXnrOnpvY
 FgVGjOR/stulcqk23pIpGuRhkKpjEdENmR2J061iMFsPh0u25IUW4AhGfMmsnNDWyRNs
 UbBAhVuS9SlNWxJC6T4jKwITiiLlty7yr+ylW26vTuffttHSRdGgk0Y8WCYi1RQKuX9x
 Jwdh/1BVvZ3/7HlQ1ec76JfA0REI3MbktUAS4Co23mRffOavY8re2bEkXEV5Zih8rTUK
 1gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745000313; x=1745605113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWOnkhekMEQCtny4NUhBNV9MyF58GlI8rqf9FkSByFg=;
 b=QKR4dMgGsuNVEbMquw76iQzecNKxyEzGl4xWKR1oPhFaN4AA0g9p17daA//UDw5pyf
 Aj8RuCiWF8xNm7SeuwTVZU7v3zt8cLAdqHxwyl+KOzN9Jk5Fph1WT9VY0wBLb1KzHIWx
 AKoUaTBATNqFnz/O4M1+ZCSi6SQdwlPlXpkIsWB6Rp+0sJUFKO75abjX9f1KN23KopGO
 XBHnbMb+HpA2261Z1oKVVKtohJsaTWiQZabpV9FNLUfaJJQcbW2FAks9nkDpVhaExTcA
 ldYPkfpBGwWx7WQrqxS1hkrnOYQX0c4hlCfZ+J/166c/FeSyHMAZ+FKS2bf1YNh8YQBk
 sprA==
X-Gm-Message-State: AOJu0YyJSrGUJcdSPJR0fDFnYyc6SQCGf4DdkA2FBeRmTPBYgfNw2uYd
 dBVXdOoEOa/unbg/8TWsL0YmNutJCx7vsGjwX6EtfPdMZwp8xW8xxXjFy9ad8KM=
X-Gm-Gg: ASbGncsrk9BMwYHTBEFhsUj7HUt6lbexpD8Jo4vW51L02WB0zSEIZlsXwPRY4mKugPP
 nyPtn8JiZQ5hkvS4LdhnhkcVX6IBGsRU3+2zcF7v5q69FHsyUjuOp6enyBOYpzfCOwGYjomfWUh
 lV7U0CSOvri+Q+hCL32yn/KY5T9Esu62hzObR4ZlhmfjdlPWxvzLCTGfKUwq+Zb0FTwG2S40BJS
 ZsqsuUBmDyq4FJmehWn4hAZ5oUgAk5JuocEb3vDk1FlYPvUJNttJjfn24mWtLeimRJbPeygYe1S
 1Y75jy9ZG3v3OI0G2UdEBuonPESHDUf9bLAQtBDiOyAOTq7DHhjA/Pa9xwPZ2usTgWhfgIMpr8Z
 XkkdrOhSbUUz2Y58EZl5ZxXwzlMs=
X-Google-Smtp-Source: AGHT+IGbGAqV+x0wX8qhW4oZYrP/LrzQfm4crO8macDQ5+jS0kTYnmR6odhq1p8Bcsuzr4W0yot+gw==
X-Received: by 2002:a05:6a00:1907:b0:736:5dae:6b0d with SMTP id
 d2e1a72fcca58-73dc14b430cmr4107882b3a.10.1745000313041; 
 Fri, 18 Apr 2025 11:18:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfae97dasm1868751b3a.162.2025.04.18.11.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:18:32 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:18:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [RFC 00/18] add hinic3 PMD driver
Message-ID: <20250418111831.09717389@hermes.local>
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:05:46 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> *** BLURB HERE ***
> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.


You are supposed to remove the "*** BLURB HERE ***" when editing
the commit message.
