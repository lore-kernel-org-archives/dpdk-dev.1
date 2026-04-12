Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE9BE937EA
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Apr 2026 16:20:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2CC04025A;
	Sun, 12 Apr 2026 18:20:45 +0200 (CEST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mails.dpdk.org (Postfix) with ESMTP id 98BAC4025A
 for <dev@dpdk.org>; Sun, 12 Apr 2026 18:20:43 +0200 (CEST)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-471618e202bso883235b6e.2
 for <dev@dpdk.org>; Sun, 12 Apr 2026 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776010842;
 x=1776615642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eA9N/ODo3xRNFc/dep6FKyUKK3UxxbL7s5ukWcGG/mI=;
 b=n3g8nFgRHQxgtU8KzDjIDPGcFC/x5IN/x6Tk1slh/O39hHkkszeBApaENQ4C2Waupn
 zIOPRqVAOPNPeMojyr86oILMLNslnwR9TTitt2Rmeb+jVSfZP65cQL3iYJZT/19mAkZp
 J8nWJhTVSh8Ctf/6HSYMX1dqs/w24VYxB8TCjmNWu2WGae+V0viBYXqlDmd4EA1S2AKx
 nmE/H99A/DmSbfPFk1Iwqlw/327RpCKp+oQgaDuAiFEHfQImo+TA2NhuUez16nC97z23
 KnvMudh8ECzZt0zibR9gdPDKC/FEdZXeLVdYsbjlVmELSnBvwTPwb+e+dHF8D7b8O8jl
 ++cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776010842; x=1776615642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eA9N/ODo3xRNFc/dep6FKyUKK3UxxbL7s5ukWcGG/mI=;
 b=je/5RcMRlme1qQ0R01pNYzsFP/yd6RExnRcjj9tPjHw3f9ndWrG1A2wVgVgxj12ckg
 FeFZ2FSmVdDt6fceMiPex67ScAPnnMULPzU/HWlOet8jczBdeC/U3qqdpotV2iEAywBy
 nGTaieQJf2FZADnOz+NZfxVHAq32D5qRrhBEO9/qmk8QPRSFI9N12Nxb//G/BgG0VcTp
 eDk9Q1yZr/JWt0JTo1n+gIQXvKsDB6FHFM4TXcMb6F+dXpEpBsmOkkZO1tHwgrNPKDFV
 GzqScv1rG5iaB7FDjWgTRB8d5zs/3GTPk7SEATaAosl67E68YtmppGubvuPxdEpOGV6X
 SHUQ==
X-Gm-Message-State: AOJu0YyUutqllZ2Tqcm7vOPi3ZMUYU6sYe/xlW6dZPoDc049SOn62a2g
 eGKj+NRQiG119JvL7hkLXfsekntN1ttF2adqhfg4nfmwNPqHFuFBeaRRoHe7HfqHWVQ=
X-Gm-Gg: AeBDieuHT4TOHwEWykT17iyky4NGiucQy4RaZHYCK+K+yIy+rMETEzDAzfUJDVkndGo
 exXwzrNHx6EjK/zGvHkWogyj7i6e4V0MdNTlMvnCllahQ4L4XQk0HxbI3/bRWzSc1n3GB2bhoH1
 84xg1V3lO3KVkv4xmKULf6wKZrWNabFjs6dryxWJvLjA+f9jEPQjUxmA9Zoarb46aRl8iSMS5lk
 hRRlZIBOxM+g/cjMX/d0hPkKkdb1rHRLDZq1WjT2o5Be0pOk1yi/gl6JUN1YkBHvqPEbO05YTSE
 agF0Bz/kqN0ki+RSXj1sI0gdqlgufBtBB8/seULA0zMEVEXqvjgwp35SjJTfn6fanUi+g0JZywS
 cI2ccWpY4Zn6WhLcXa0RuT/sUdi8c60ue/J1grcfSDPhJIDmGFY/yRZgrVFLRp5aUajjI9XAUeo
 n8ecuIt+Ajm4AYIU85N1r4J4s3NgDzosgtxon2XMONlz8V6g==
X-Received: by 2002:a05:6808:67c5:b0:45e:a592:5903 with SMTP id
 5614622812f47-4789e71ecf1mr5346594b6e.32.1776010842606; 
 Sun, 12 Apr 2026 09:20:42 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a080b96esm4907537b6e.3.2026.04.12.09.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:20:42 -0700 (PDT)
Date: Sun, 12 Apr 2026 09:20:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: KAVYA AV <kavyax.a.v@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 shaiq.wani@intel.com, stable@dpdk.org
Subject: Re: [PATCH v4] app/testpmd: fix DCB queue allocation for VMDq devices
Message-ID: <20260412092033.55207b38@phoenix.local>
In-Reply-To: <20260409064346.3513111-1-kavyax.a.v@intel.com>
References: <20260313101553.1827216-1-kavyax.a.v@intel.com>
 <20260409064346.3513111-1-kavyax.a.v@intel.com>
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

On Thu,  9 Apr 2026 06:43:46 +0000
KAVYA AV <kavyax.a.v@intel.com> wrote:

> When using DCB mode with VT disabled and requesting more queues than
> traffic classes (e.g., rxq=64 with 8 TCs), testpmd crashes with null
> pointer errors because it artificially limits queue allocation to
> num_tcs.
> 
> For VMDq devices, use actual VMDq queue layout (vmdq_queue_num) instead
> of limiting to num_tcs. This allows VMDq devices to utilize their full
> queue capacity while maintaining compatibility with non-VMDq devices.
> 
> Fixes: 2169699b15fc ("app/testpmd: add queue restriction in DCB command")
> Cc: stable@dpdk.org
> 
> Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
> ---

Applied to next-net
