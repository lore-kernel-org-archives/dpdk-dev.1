Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33930C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:12:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A60F40292;
	Thu, 20 Feb 2025 17:12:03 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id F38ED40041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:12:01 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-219f8263ae0so24797705ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740067921;
 x=1740672721; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LbmXMchiUt5gFzDdEGWhI5gmq2Mlws1evuia/fXq70=;
 b=eiPw/+ekx3Tmy6lZIL16Nu8/hfXpc5oTWn2nMV96GwOBc2HtQszbh5Wk5O6Qt2oN5j
 ncKilv1rhuaUnMjykRpPuOFDxL6qtXW8o1I1Eeh3YEJ/SsNQxSYRuLb9rtPyjcukXgRs
 R+KuQXD31xIT2gC26mxsvny8zLqYA8MApIBg+lUmmoUiJXlxhAiJFKy8oR5h3MC1RDk/
 yYXD26GS+OGdIHvuFDCWaH/g/oNCWH8ZyAvihgxiIF0k+6KSlbG8Zp1X8eWCFzj3SWgC
 YsF6TM0w1QVwQ4QmT1iXBf6LZcrL0mNo+RWTI+HFzPvjziGwDXl9UHbQ3qXh6mz815GS
 +BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740067921; x=1740672721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LbmXMchiUt5gFzDdEGWhI5gmq2Mlws1evuia/fXq70=;
 b=gIQp5nF1sbLnkVFZMzBNJFF6CwmhWDVOeB083oAzRK4QiAgu79HtB8qFIot4DnOyrt
 RfsMsMy/BlLFuRj4UNVyoryUZvXuqNqwxjx0C0zMeuv9ilFVD9hG77n8+RJYrilYa6F8
 w7sr21fSB2PEubA6J5FXQcSmqz9x1yhtaF46oiTDZIdf/OQzm6XxK8rPsEiUdbrKCXA9
 irM3e06VaYNZjHbIXrYFZXc9FvtUT+fnwQuQk/LBVGgl4q22dq46GA5mNq23c8nVJ1EH
 XTTg2N1lmhxiXj0qbxnFgP3Y/7C9NU8QvomJCnMaQ+PxYbGQ2jFBvM/okR7z4jFEuAms
 5LRg==
X-Gm-Message-State: AOJu0YzqyehNoibC4wBOK7ZoIZWgqGo6o1NnI7DvzC/92fKU4NMGtESC
 fpnX4J8DznpnwyTDlwHtst1kmixPK+noUAAF8t2ONB36aCZeIxtXAh4lUODs7tg=
X-Gm-Gg: ASbGncv0zOO6bMJDoZV+dUU75LzTBHIbWli/qaqTvgoaGkfnWcc2ALeE+IPcsjPpMhb
 gfklreuPbgWvHr9P04wVeOxF7Ldq+zNnV5HKckBCXErhS1mAXGIEvBr26glQs6ym1hE6u6bQbQy
 PjjChQXf0VKTYFj/+cjcZhMaP/LJ8ByrxZhTrpyV8PLM9l9WFDxguA9j/+X8fPsfP4EkT4MweNa
 rB6bbR7iiyJwuADWYV60dZ9kWiSoLuzOBnOs/fFGMDJraaYKum/xWsKWfZ1KlqOQQNKwUNY34V+
 QESpWz1PmlxUMVEfNYm41cDEUMhxWf3ZEcrdeUo7xCjtwiz2qvQg0wTVrjr1cqbaN2M3
X-Google-Smtp-Source: AGHT+IG/QYBlGVfaBLDfDFHAND8OQrbkn4nfV/4MvAv4YFebhYBKJax6dIyDhVihn6zcVCCL4wu7fw==
X-Received: by 2002:a17:902:7c89:b0:220:ea90:191e with SMTP id
 d9443c01a7336-22103efc1bbmr275535875ad.4.1740067921051; 
 Thu, 20 Feb 2025 08:12:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d534906csm123763975ad.52.2025.02.20.08.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:12:00 -0800 (PST)
Date: Thu, 20 Feb 2025 08:11:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <david.hunt@intel.com>,
 <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <liuyonglong@huawei.com>
Subject: Re: [PATCH] power: use hugepage memory for queue list entry structure
Message-ID: <20250220081158.345f09b0@hermes.local>
In-Reply-To: <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
References: <20241219075319.8874-1-lihuisong@huawei.com>
 <01d163c6-6d18-03e8-ac67-e7907d27bd08@huawei.com>
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

On Thu, 20 Feb 2025 17:01:53 +0800
"lihuisong (C)" <lihuisong@huawei.com> wrote:

> > The queue_list_entry structure data is used in rx_callback of io path
> > when enable PMD Power Management. However its memory is currently from
> > normal heap memory. For better performance, use hugepage memory to
> > replace it.
> >
> > Signed-off-by: Huisong Li <lihuisong@huawei.com>

How is that in a hot path where this could matter?
The safety rails in rte_malloc() are much less than regular malloc().
I prefer some degree of safety from checkers and malloc library internals.
