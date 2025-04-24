Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E94DC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 20:00:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5E594025E;
	Thu, 24 Apr 2025 22:00:01 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id D3794400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 21:59:59 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso13882025ad.1
 for <dev@dpdk.org>; Thu, 24 Apr 2025 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745524799;
 x=1746129599; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nO3tHg0n3GmsuZKyspfj4VPxtOg8BXKUuUhN6We8NNM=;
 b=sPT9uNH7w9ZncTcsQV4X96sVEccRz5UBb7So0UNwHHzxAiWKh2YJZ/II4KMsk+LGS6
 mku3x5NghBkfAREHP7vczj8dlA9dkf9KLYHfyLu18IaOZlmjllnz2gduXjlJfFNmsHfB
 1AGqtc674ffhpCG9zuzPelFJyt3UHhgOR2fUaTAOZUW7G0Z80lu7eR6wnYs8RuVcEjC2
 kg+uxwWK/Fj/BEFd+y/IoO+bIQQ/VQZx5viKyxIVg5vvoE4yqSieAs2uNLclSBfZBgmP
 pJm/48nqOsej/UuPoOBwFyG8yP3KoqJnZ0f6az19Q9TUoQVtTOWAROjGWkH20K2QAQV2
 IBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745524799; x=1746129599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nO3tHg0n3GmsuZKyspfj4VPxtOg8BXKUuUhN6We8NNM=;
 b=wYbJrjvDgBBmy0Lg7khIVo5OxhSXICrOhiWBRcT9Uw7CY1IjLMxs4HWfMuYC3tRDhO
 nKfARDBb4QCnIrA+boUYA9jF1nXcHmnK5w/UG3zC1cDAE/QN9YzAaqD4eA8lNHO6KCwy
 Fi/ClMfwzO6YFDJBupCd10jfWXQCGiqeoxnE84mPGYnG1OKECuVgIQXpevROM71Y9UlI
 PJRgAUp+uUClyXwGbMnxO0f3QjfwKhRL/p2zZbfMBU867oqEclb4rZchtNTn5nXx1gn2
 GbFg4xBE+7AUPXBqdYBLdhde2A5VfQh4nNqMTRWOLzjEt5HExqaX+14+iMb38K/25kl6
 CKtw==
X-Gm-Message-State: AOJu0YwpN+cX6y/eoTYRyuWvalhO5mcAZnO6ZSZHjLnhMrSXPOriULc0
 rfV0KjNJWuZj3enwaXq2ybdm/NRyZaDOlBxiVlTCi1zh5+OBhXqqmzk7iF9sWU8=
X-Gm-Gg: ASbGncvV04XvNNW/LYLDt8b+85JJXToXaeu0M7JBGryFSZYLO7C0d8GVrd0wJZ8CnAT
 tK5PZOsBinkAB4qMHe2Lb9s1RVufDhQ7GsoTxX/K6ORPmcRNak8cHlTsJ4uwbDitsf3U9XpOj/X
 oySGrh23ONc0AJFbtDHeuljrgBsiYKU3Y8JmEpFTo6LjoDBPs1d4Ok7ss9+ZLCClfdc8Lm/4RFP
 a1BmgP8UBBzjzHtviVXUh1eeNkGJtynQdja4gLik080UzrYiGvR8EBrHc9CfZ5TReV7l+cKunsp
 qE8JALKYd8bsmtJ0d2bMeeRmLqk8e18+ZEYNecLNLZtsBL2BP5CPUYJKwK9cDT7ypYRZhngEZ0N
 rTa5aLq8vzYAPYNJz
X-Google-Smtp-Source: AGHT+IEPnpFBGqeTdk7lmkiOfxMVURziadt+aElcyze9u5W329JO1SjQNgSYa/XU7AZzLslwHNu7tg==
X-Received: by 2002:a17:902:cf01:b0:216:271d:e06c with SMTP id
 d9443c01a7336-22db47ae98amr49511805ad.4.1745524798643; 
 Thu, 24 Apr 2025 12:59:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7a28sm17845885ad.110.2025.04.24.12.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 12:59:58 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:59:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH v2 18/45] common/sfc_efx/base: update MCDI headers
Message-ID: <20250424125956.7ac934ba@hermes.local>
In-Reply-To: <20250423160002.35706-19-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-19-ivan.malov@arknetworks.am>
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

On Wed, 23 Apr 2025 19:59:35 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Pick up new X4 network port MCDI defines.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
> ---

Lots of spelling errors in base code.

## [PATCH] common/sfc_efx/base: update MCDI headers

WARNING:TYPO_SPELLING: 'negotation' may be misspelled - perhaps 'negotiation'?
#747: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:6903:
+ * negotation is enabled and MC_CMD_SET_MAC_IN/FCTL is set to
    ^^^^^^^^^^

WARNING:REPEATED_WORD: Possible repeated word: 'from'
#1202: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:11518:
+ * correspond to a sensor currently managed by the MC will be dropped from from

WARNING:REPEATED_WORD: Possible repeated word: 'from'
#1211: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:11565:
+ * by the MC will be dropped from from the response. This may happen when a

WARNING:REPEATED_WORD: Possible repeated word: 'the'
#2201: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:12626:
+ * consistent upon copying the the DMA buffer. If they do not match, it means

WARNING:REPEATED_WORD: Possible repeated word: 'field'
#2654: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:13079:
+ * SIZEOF_NET_PORT_HANDLE_DESC field field as the array stride between entries.

WARNING:TYPO_SPELLING: 'intepreted' may be misspelled - perhaps 'interpreted'?
#2774: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:13199:
+/* String of the vendor name as intepreted by NMC firmware. NMC firmware
                                 ^^^^^^^^^^

WARNING:TYPO_SPELLING: 'intepreted' may be misspelled - perhaps 'interpreted'?
#2783: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:13208:
+/* The vendor part number as intepreted by NMC firmware. The field is presented
                              ^^^^^^^^^^

WARNING:TYPO_SPELLING: 'retreive' may be misspelled - perhaps 'retrieve'?
#2819: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:13244:
+/* Handle to the port to from which to retreive properties */
                                        ^^^^^^^^

WARNING:TYPO_SPELLING: 'overriden' may be misspelled - perhaps 'overridden'?
#3986: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:18289:
+ * with the values set to current global value or they can be overriden using
                                                               ^^^^^^^^^

WARNING:TYPO_SPELLING: 'tbe' may be misspelled - perhaps 'the'?
#6096: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:39493:
+ * against the target region in addition to tbe check performed by
                                             ^^^
