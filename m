Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E794CD3423
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 May 2026 03:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 149AA402BC;
	Sun,  3 May 2026 05:29:54 +0200 (CEST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id E779F40269
 for <dev@dpdk.org>; Sun,  3 May 2026 05:29:52 +0200 (CEST)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d1872504cbso2621078a34.0
 for <dev@dpdk.org>; Sat, 02 May 2026 20:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777778992;
 x=1778383792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuJv9b8P+azm5+Qnx51lr99/Q7RJCv3iJnl/OfEOkHk=;
 b=T28zdehDaBunLyxuvMMM6VuXFCzzWwyl0BG2tVd7yAsdzSSTYGUOQz4BgREdKKKYqn
 3n3dvNi6L9VOnG29HaYr96XcbgxvCE57C3KXbuQVm0nA5JkI324oqAYleL2G2MrZMRX8
 meRsJxCi/ieHbzdE156ZfhXEc4WbpUnJ6XvqiVLlnKMY0AUkiVl6zDOv10ightbmosYU
 nyS/tFMiAg/RPhNquGUkmJcNdI0qbYiuvZerF5m2RuDJVkraA5NXDZhMZWZc2zdU4s2Y
 Cz92BlTjXMHQHcl89p3jjaNSd5pU7iTH0HJhNimRD+9Ww01Xu7215yhgxignO+kE8yrp
 zxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777778992; x=1778383792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yuJv9b8P+azm5+Qnx51lr99/Q7RJCv3iJnl/OfEOkHk=;
 b=D9I7t65TvzMeUe00+k5x6AOr/zzP3oRGdqUmfD2QmDMgSzdq+yBlulG/A/83uLvYul
 86b5lKg3KwMAhgVWJ6Djf9faMMEHR2hIv+sb63gEsENjDOj9UNwelvkz7BzIA/+XODNC
 q6ji6YEWPDiGaWmvANu1RCEHW0yDIeYDiQ+v7R7zPtGEtsQHZRFJ7VLLzU7m/j9AHmu8
 pZWxZfSNIhf5we/Y9bMQJxI6j+oAM+z4aQi+P9+rse7pqu3yIfoMP55FYNGzhiX+BDEB
 NJbyJsAjD+pjL4AnMgs7cqKLrHdJ5yNyrdxe/ryIJWiunWV7OSmR/cxkqFECrqw2ebj5
 Lotg==
X-Gm-Message-State: AOJu0YzeWikSS5x6L7oIl/mxa86uS+YphVsIg0DOS2/5xTO6zX7Q5mWN
 Gf8abIimIy/63IGEANqMti0eANERz7kyr0T4fR8GiUzbG8vzCcdg6bzjIx5zjetBaas=
X-Gm-Gg: AeBDiev1bCNA0g+0wMGBh+3ri7XJdfMTtExiJ6NwQsPnEQGsFMZ5xqzxkijGVk0BT46
 EnZmX7q41TSa9+8aYJFSdaihL7327bWjtccjjDszS5riEvjWBy3dS0p660md4eFWy85CyMXcVqj
 rsKyEOM+4MY9xP9PYe/3dwu1dI137Cfp7+A/FrC1cyyUhyJa0eb0N180hgXh5NmSn9JAKyOzqGh
 dq41SZWVYeJ3AmM/FB0lQPnMk3/d9LWFMr788cgz4uUlr1yH+udBUduCrX5EimyOLsK9m5VarwR
 SjMQ+NDFlM92tO73uGTtsgw1HCGY/lYzL6Ot89dP1rW6ejFVmsxt6bmMtX8273ktdt+uoHbgL2l
 4v9SihetrE/2EozdWfgCT5l1/9jSvs9K3VSWkV811nUnWq1xxvVS+X4itXpsNEQMGglaZIbTLXJ
 F2wL7LCaBmf55Rt7SjD2RsN/n5Cyd5gY7vLzwLAAagIWoGfjTpwXRHxL2d
X-Received: by 2002:a05:6830:6dd0:b0:7db:d6c8:a21a with SMTP id
 46e09a7af769-7debe2c92c5mr4901742a34.3.1777778991957; 
 Sat, 02 May 2026 20:29:51 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca80d5b7sm5295178a34.9.2026.05.02.20.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 20:29:51 -0700 (PDT)
Date: Sat, 2 May 2026 20:29:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v3] net/tap: use offsets provided by rte_net_get_ptype
Message-ID: <20260502202948.279aba3b@phoenix.local>
In-Reply-To: <20260430232806.125220-2-rjarry@redhat.com>
References: <20260422133615.680318-2-rjarry@redhat.com>
 <20260430232806.125220-2-rjarry@redhat.com>
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

On Fri,  1 May 2026 01:28:07 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> Instead of guessing what are the proper header lengths, pass
> a rte_net_hdr_lens struct to rte_net_get_ptype and use it to get the
> proper header lengths/offsets in tap_verify_csum.
> 
> This allows supporting stacked VLAN/QinQ tags and IPv6 extensions.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

LGTM, AI found a couple of small things.

Info: stale comment
In the same else branch, the comment is now inaccurate since l3 can
also be RTE_PTYPE_L3_IPV6_EXT:
} else { /* l3 == RTE_PTYPE_L3_IPV6, checked above */

Info: cover letter
The "supporting [...] IPv6 extensions" claim should be qualified or
removed depending on which fix is taken. The header-length and offset
math is now extension-aware, but L4 checksum validation is not.
