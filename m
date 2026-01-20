Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4576D2ECF8
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 00:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AFE040274;
	Tue, 20 Jan 2026 01:14:30 +0100 (CET)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 0BE434026D
 for <dev@dpdk.org>; Tue, 20 Jan 2026 01:14:28 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-652fec696c9so8593370a12.3
 for <dev@dpdk.org>; Mon, 19 Jan 2026 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768868068;
 x=1769472868; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuGL6AtBtb0AjJDj5wOGdUZXtczPxUo4Lrtnxip0ggE=;
 b=moCe0sRYZ91LEHjx5VEy7HrL8+HxY50QJURkinSD/OwmgCryzSGI99kU0CbpVxQB3l
 YS6aUeR0E2qBBIAND+NGiDjhWlrP0du5lzkcN5+d1bPyVxB/3X8nFY73buYycxwz6Xz1
 VJLcjErYxlsRVhohrxkvjI6oS4mBJzMVBFBzrjYfFxq/2BX0+9xoPLGb9M2/2lSxTw3s
 vkJ2DEQ+0goueEs8YXRrDlMhOy1QyPT5+Oz/0SuLjIg5OJTZA8h+hUAIh2sW/xCeaVJZ
 KJakelFFXsP0zXAd3KcTl1KICfXVPPNUvIMcXtAeYwXOwQ+nwKeyeW/4Rmc8Rx/KTww/
 BnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768868068; x=1769472868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kuGL6AtBtb0AjJDj5wOGdUZXtczPxUo4Lrtnxip0ggE=;
 b=RybP7hdmgyTANJnAJ2t9tHzJhn8M3AMnxKQbUzEFIEuQThNQDsCp/24s1GIKNRIAPR
 YJGS9Mivw5BX1KOAAl6sqHRZtHjhj5Xt/AisQGSwZ9Cxk1H77Eh/KXeWVu9oiqFovkLg
 ksX7wsDEOD4gs9ssI/B801QVOn82HulTZto0HJYYMR5gjJjiDMxkvl4q28zaUmIA0kR/
 bzE5umgZcx8exBlLhX9DSUmQm+qjcuCRaqApLyJAmFWO/QsMohY2G1DZawpGjqISuET+
 5JvTkzhpiHAiXKT9h4nry4RrMaK66lQPIMZXxsGrdCV1UWi8wpRhpxFNNbvyOqxR0zzA
 WLUg==
X-Gm-Message-State: AOJu0YwlOMsnuIY1Wu3k7XsMMnMNIaA6aRr6KQDIYlJMJ5rPS4A+69l3
 9aR0DZVxrJKoFOplqgCJCZDo0JtDJF50lxRd+sQlkvtWskv7qeBCJTgXy1KZA8rg900OmWoxs2O
 1mxOU
X-Gm-Gg: AZuq6aJ8q0s2XdNe2/o07BXpGIfdhv2MoK0Ah0yGVc20GmC/QOF+nwNIaTX6c+Ghd3c
 mFCt8Zkzg1zzoUoh3yvJndc3y06B5MQHU5Hf+a9qzk72Co/2aIppqNX4we0XIGglJk79/jWxW3h
 uiqznrPYnDBfgtjBRNYDuWK8tzdPm7VVn5ENo2yhVyX3ZVaGcqN0H1D2f1OXB08witUYNci/TPS
 ymsa2BERlrLFh3rZLCI8gSdkLSNxBx+7FTzdA/Vk7BC3RtN30aF1MliVx3dZ5rS+zx6y3x1Uyxd
 96puX9NtYGeX88xqiQJcwkwuFeLV9RrnLAtPtfsoUAtGjLLtwS+COYNhbWl7Fg6YBHejhnCWuVH
 XofOlkhP3mVki3EkhYRT/p8OV6iNGoiCneDNlQtXuHHwAZ1DAZtriobt9ju2+qtgPqqDYYcSRFO
 ePrfvwywsaMFKA4ApT6huwDlZgoiUILuOO3udX72oj4kZStcinuuQKGSKsXGaJiNk=
X-Received: by 2002:a05:6402:42c1:b0:647:9380:103c with SMTP id
 4fb4d7f45d1cf-654525cbeb1mr10894525a12.13.1768868068519; 
 Mon, 19 Jan 2026 16:14:28 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdb0e4sm11388853a12.13.2026.01.19.16.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 16:14:27 -0800 (PST)
Date: Mon, 19 Jan 2026 16:10:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 5/6] net/nfb: release allocated resources correctly
Message-ID: <20260119161044.552ed2ff@phoenix.local>
In-Reply-To: <20260116152057.1456380-6-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-6-spinler@cesnet.cz>
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

On Fri, 16 Jan 2026 16:20:56 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> Internal handles are initialized in eth_dev_init, so the cleanup
> should be done in eth_dev_uninit.
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---

Looks like a bugfix and should have Fixes tag.
