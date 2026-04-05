Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23FFE9D80D
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 18:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70D4A40285;
	Sun,  5 Apr 2026 20:47:29 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id DD46F40265
 for <dev@dpdk.org>; Sun,  5 Apr 2026 20:47:25 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso4303814c88.0
 for <dev@dpdk.org>; Sun, 05 Apr 2026 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775414845;
 x=1776019645; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5qVRsy4CNjPdnyhMgoa7pBeuGdxFrbWl3FR4mIOo3s=;
 b=GlBDL8GnX9BuNOxGSq5Ct73S0enrUh61K8/MM9qN1nEf1r19WQ++02mFYaWbf9WXE7
 CXDvv3bUAFu6ukFL3pilBQlwbHz3Pi+AswEB+vrgJ0duqaddjgiQnDKx4gM8ecVoiQIa
 g7xaE3qQ2cVBtIXOauhrSmkersVtHq0IyDM0NFOioNAg7nwKWSyLzauOGgKNNaMcwZHN
 fYH4DsZ9xeMHLiA3VTZ7CWRC1rT5DsbhBTHFyEyoP/hvC1ifuPUpKnmMtWQnDOhjA0pL
 Bl6Sy9SP3AnMlIjEDRViU8PoSPlIYHVxyhP3+PjJPrXoth3XmFlzDYSMBS/8T+8/hF9Q
 LpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775414845; x=1776019645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q5qVRsy4CNjPdnyhMgoa7pBeuGdxFrbWl3FR4mIOo3s=;
 b=YeMVsIbDZRWGNWQ7bvEAjcRCEzsnK5OjVVZxvNmCz0nOZhLuhpD+5W3OgcShX2U1rX
 8MBnfM9lhpDkcKMv9T/xc25lvNb0Gn6gNZ9+fe+aDS73Ik78qhICtgiuc2uptyZR0Vs6
 zCjzc0L4qXgjGnX7NSHzHgWMUpqgZinFFqjdi0wY+lF+MmI/2SK0FgFrJSmlDXhS+T7K
 n0oRft02iNwMsJdald5S62o+TZhSoFYwyxo2pivIwnrBNy42uT6bOezSS7EtRtoP7Jel
 2E5nMCORS9Zwi4y12nqbPgndCdVAsaLiqOCX0BHYhoFqZCnspMc2ymdXp85+6wqocfAb
 R47Q==
X-Gm-Message-State: AOJu0YwlAXx++onZAnl1lwuT9r8uxBpKMg33P006AkmFq84TLb7HS8Ff
 NstKxYOIWtUH4L00XEibAkL+CCqMoOm/Xafj6duw4lBYxQ2mCs+P8fgptEPsm/NzWP8=
X-Gm-Gg: AeBDietjCRsY5Lp5D0oGYW22XldmViWRpgPD2fMaZkwT0PDS+aUvn6ogkjcm3XLn6Pm
 VXk26FxzyjdqkDFf1J4xG3CGQE77AHqv8WO++B33jr0nycIHTyKzPT34C8IUStfwgYE414Z2zn3
 iz+sfzKmRvYTclCCZ5H/p7WvAzshoJvvJ9izUJDNf923n4KP0eU8RC6uKoDWxh5RM40YW6vfgqr
 hXUsWwp1Yy3IBQtg7XWoJridwzN9kDZHTv1lkgI3qy0GHxYc2wkf7CEajg9DDGioqHAhncYL13n
 q0g4rgwl7wpZhuo32w8gdl1tNizP1Jp59iP70x4CMXsSxv/qO1XcE4iy3GvRR7qb+CW3x32F2oD
 lKLIn5nPfjEu9WWyW0FJEeZ64yob6A2b2SYU10aySGtoP4v01HRHd+DUvbRKDh6edCe91sYafiA
 I4lVquRZ2SIKvcfpS5NyLsC0VaXVbgofpwkbI=
X-Received: by 2002:a05:7022:41a3:b0:12b:f881:d8fb with SMTP id
 a92af1059eb24-12bfb6ec86fmr5222643c88.3.1775414844932; 
 Sun, 05 Apr 2026 11:47:24 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede7f542sm9877848c88.14.2026.04.05.11.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 11:47:24 -0700 (PDT)
Date: Sun, 5 Apr 2026 11:47:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com
Subject: Re: [PATCH 0/4] Remove limitations coming from legacy VMDq
Message-ID: <20260405114720.081a3b56@phoenix.local>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
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

On Fri,  3 Apr 2026 11:18:31 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
> VMDq has been imposing a maximum number of mac addresses in the
> mac_addr_add/del API.
> 
> Nowadays, new Intel drivers do not support the feature and few other
> drivers implement this feature.
> 
> This series proposes to flag drivers that support the feature, and
> remove the limit of number of mac addresses for others.
> 
> Next step could be to remove the VMDq pool notion from the generic API.
> However I have some concern about this, as changing the quite stable
> mac_addr_add/del API now seems a lot of noise for not much benefit.
> 
> 

Make sense. The AI review found a couple of things.
Had to poke at it to make a good description

Subject: Re: [PATCH 1/4] ethdev: skip VMDq pools unless configured

Patches 1/4 and 3/4 look good to me.

Patch 2/4 has two issues:

1) In bnxt_reps.c, the new line:

  dev_info->dev_capa = RTE_ETH_DEV_CAPA_VMDQ;

overwrites any default capabilities that were previously set before
the driver callback. The other drivers in this patch had the same
pre-existing pattern (plain assignment before &= ~FLOW_RULE_KEEP),
so for them it's no worse. But bnxt_reps.c previously only did the
&= ~ clear, so this is a new regression. Should be |= instead of =.

2) Several drivers that receive RTE_ETH_DEV_CAPA_VMDQ don't actually
support VMDq: e1000/em, bnxt representors, and i40e VF representors
have no max_vmdq_pools or VMDq configuration. Marking them as
VMDq-capable seems incorrect and would allow users to attempt VMDq
configuration on devices that can't handle it.

Patch 4/4 has a stack overflow:

iavf_add_del_all_mac_addr() allocates list_req on the stack with
addr[IAVF_UC_MACADDR_MAX]. At 32768 entries of ~8 bytes each,
that's roughly 256 KiB on the stack. This will blow the stack
on most configurations. Needs to be heap-allocated.
