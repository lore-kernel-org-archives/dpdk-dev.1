Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE7C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 783BC402DC;
	Mon, 21 Jul 2025 17:37:07 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 04C7340297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:37:06 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7d9eac11358so443880185a.3
 for <dev@dpdk.org>; Mon, 21 Jul 2025 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753112225;
 x=1753717025; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKtzRTkeOE/KJu9AjNrDD7ulSX7wLbmrLL6Z4NxMD3o=;
 b=aDHWRUDrmQJMg/38F6p2YJy0pYMq0oIPIXSDzgz6xlEihb9SUypHycTxoNar+RfpaW
 wLJPPh/rp5R8X7jggfdkZZrGphBw0yEII3XqgoBiAlGahSRUzrwk/UO157YWP9NayK9i
 H9Bf2VMOwMUmoxIf+JfhePeJL0LtJXclTtzJT+baWI3EwL077zaBRZ+CpayZIatLh4yT
 UyfDDwOPufg1mSa+gZ4VMBAtUOq6eoXVCNhW+bc/WFZFz7rBOJM5PqvuU1MLqkVlDO7o
 oG6sn2LwfPOe2F1fxRJWpfhI/fpj04xVUd9xMCp4OoSuD+DM0QOZWxKPnjdCe6RU2SHo
 voBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112225; x=1753717025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKtzRTkeOE/KJu9AjNrDD7ulSX7wLbmrLL6Z4NxMD3o=;
 b=d/JIVVehbo13rxBbcVx4mzDIj/MIpUwsbXwDKdfQJ0uiP4FKTCSbzoU6FR3ohVnkCQ
 iI+AzJ3ZCUsxVuFI15J4nAFKUrtJQ6hLPqvEkfBpthjRkA12efk59jc49CFKS4vFiXCB
 0x0W45rSMPln1Ht2x9c0ZsCzzoNSpsKA1wUmhXxOFAwk4SuUC+11HBeds4aCWQhGARux
 1qqRVRHyV7AS2zcY7WDIH9hvPU746ZPQ+yW7mRDN7XZfXgsFt6Uz3DEnpmqY+Uzl5MvH
 DOZG0KtOwVE9cvLrbGJoxEgjnB0yMk0PYXaWWwzEW6RCePhN+j3WTJfHrYa8J9dO3tmu
 80qw==
X-Gm-Message-State: AOJu0YyXDpCd94IFIg+TI9dTYRFDhjwZtOXbsVlwykArIfx+K5Lg9Kbb
 yJF/Yd/TUlKg49x5ciDtbVkhAPbVG0WkYIZucGjRtsLRFdoOR3kWpkPgRKAqcZQm2iFK+k6RlpT
 RHOD0
X-Gm-Gg: ASbGncsI9fFy9cnWwdNBas+fEIrnY/LtjoQg7BTKSfzxZAoSXk8n6eAXtHtamjhVgRp
 SdYOHSeYtoZUaL8WvLEiCSoLb2n4KByazG0kysK2ooZIwpu3CoB7tQHkWzDpgGGW1tiYPJp73gz
 c3++axcIzDCjQo6PBAC2dmGTEm3YxxQnFkdTbqNEeHKQ49/hD8EOSqThMaYPawBzJhUnmUDJ5Nh
 rHzlMcxig8j5Pt+S4PIZt3OzoKGph4sMYFCGfLRp3/ACD1fwlkA4dRbRUWVX4bB10LSsWvXVhw3
 42mR2/ZoDDUOk1TLNQDFfnuUf2FqRYTAxlrHFcQ8EnNKp7ggowZckug0FN1fJKhsXSLgJVd4aY9
 jnH8ZQyb7Td4oZraLYOHdPZv/xPAsnGAslptUijXXz79o73LaaKJgILUbtUBWgEOvcjrR5MF+Vg
 A=
X-Google-Smtp-Source: AGHT+IHWhlAuMMyjfUfoUpqk+o5qrW1zAliq4f+ftQ9CTV61E5aVglq7fcszRjzFlSBtqddZTyVueg==
X-Received: by 2002:a05:620a:55bc:b0:7e1:b368:e4a8 with SMTP id
 af79cd13be357-7e34d9d3564mr2130692685a.48.1753112225292; 
 Mon, 21 Jul 2025 08:37:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b46025sm425003585a.29.2025.07.21.08.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:37:05 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:37:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 14/14] net/sxe: add Solve compilation problems.
Message-ID: <20250721083702.72aa946d@hermes.local>
In-Reply-To: <20250719090537.699357-14-liujie5@linkdatatechnology.com>
References: <20250716082930.83026-14-liujie5@linkdatatechnology.com>
 <20250719090537.699357-1-liujie5@linkdatatechnology.com>
 <20250719090537.699357-14-liujie5@linkdatatechnology.com>
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

On Sat, 19 Jul 2025 17:05:37 +0800
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Add Fix compiling issues.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Build is failing on the check-doc-vs-code tool which compares
rte_flow in code vs document.
