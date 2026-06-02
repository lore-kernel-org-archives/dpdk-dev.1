Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990F9CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 20:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD110402AB;
	Tue,  2 Jun 2026 22:53:12 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 93EEC402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 22:53:10 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-137d464c47eso2133665c88.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780433589;
 x=1781038389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ErRisxpWgTGCRIwzWPa5AeG+3CCmaK455g3lGg7X7I=;
 b=KCWJWQYi+Xvw6+Of2uoBACNnjrMQeRN1X2uMRZ6HcryhRScARyIGdwgZrPu4lYubXX
 SF51HxC6YPEQqMT1cSvIfYc2FOuz27pOw+yu3dko1OQ7ZACffNvIJTrPQpLZnz7fd49+
 udLI1UfMyziRgVjEzFZW8eBbG7sggLTPtUqIfTk0b4Kh+HTXj5iv1sI/ozL/K8AQTRUk
 cPgBmC3MdQpI7et+Pf+xprubhz1hTOVGKKpbfyVO0R6MSXgcFX+5PaJsK9K2t3RfH2eI
 bvc5m9ZMfwdADzswmHiEsVRosJ0K1ptY1dtoffUjwnucqR/Js5Ck/lCmQoaJrVuPNhv7
 jyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780433589; x=1781038389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ErRisxpWgTGCRIwzWPa5AeG+3CCmaK455g3lGg7X7I=;
 b=WYLAGdaxoqjD5VFxo2yzHsoVpGZW80oordMWuuRhAf79ItHJsf+kbKv8ddvdEFfr08
 7Z/sThRjAWkg0o+c9UoOWjMYp9RV0/GrL0LH6jTWsaEZzcJxDAJ+nqubKdqHB0qBye/p
 iSL9MSBzx18Og71S5qJT9YinTqDDeBi+KaoGRznTYureFSCGVoW8/dWVhzxdHs9M8KYW
 BKnVggt6uUEO/b6WC7rW44u5m2YHSk/S1cQGrTyZOKXrXtBKQ/8KRQcL2F6qdXv/XuRq
 CLJjokXNEBVfYCT0Z9QunTyMPNiIRPodln6n8H2TqqeHbDNS5BITIBqSAElhgvs/2AjN
 o2pA==
X-Gm-Message-State: AOJu0YxFL1Jjwq6i9sY5LdUF2sZQmwxlL2B3i81/OA5Qj/UHwdJ0d8iE
 4GydcktnIX/qlX1iV6NRmjWmAw/rWjXbBUhk9aqYk1T4tWOMGVFdClTkdjLA77jjVgimrKrb4HM
 T0Bj5
X-Gm-Gg: Acq92OFsNyIjB830N7oQlwZ1X7kuvfJayXvkeiQSw1rPNDMcBNxrsVH4BGmEeDR6/tp
 W8tVfru7IGcFhLunpc9xZWBhf1BuoIXUxwTywAaemvBg4ajJf7s+jc0TurJy1ExD4rxDIYiFFbP
 Og5uHX9AtTOv4Wp5eHrgBnB3t0TSlNkc+z2HUPk1nN5RMKETq2KOe+AazlnaMjoHVFRzeXLb4ar
 OGQMv/yK5/ZNwEFT7t08lZFGXS/CkJko4DQoHc8U6aHZ3KEs44plTHP8t/Iya++o3KvPsP56vli
 zY1fRNnhMC0qKwz9XKFrvQo3VvcaReF3m3bRAqQw21No+h/oSZcEUh/f67edoJRf/0JCFgs4qt/
 JESM/FuxTNSUpKltMVaTT0Jw2n22NFcOiIASBA6soAIIsL2cTL6iiDcooPM0PjEfNKU+YFUgv0u
 SR6Hik1EAtZ6sTt+tayx6o8qohnwxD14GTm5+1M1PIEOP3ryeiWMrV5txYTv0hqBt8kEKdsI8zE
 OI=
X-Received: by 2002:a05:7300:dc0a:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-3074fa5a00dmr226766eec.1.1780433589380; 
 Tue, 02 Jun 2026 13:53:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm376693eec.25.2026.06.02.13.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 13:53:09 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:53:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Reshma Pattan
 <reshma.pattan@intel.com>, Aman Singh <aman.deep.singh@intel.com>, Naga
 Harish K S V <s.v.naga.harish.k@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Anatoly Burakov <anatoly.burakov@intel.com>, Cristian
 Dumitrescu <cristian.dumitrescu@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH v2] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Message-ID: <20260602135226.33840db1@phoenix.local>
In-Reply-To: <20260529000748.275863-1-stephen@networkplumber.org>
References: <20260409013658.965613-1-stephen@networkplumber.org>
 <20260529000748.275863-1-stephen@networkplumber.org>
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

On Thu, 28 May 2026 17:07:48 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> rte_eth_dev_get_name_by_port() uses strcpy() into a caller-provided
> buffer with no bounds checking. A mistaken caller that supplies a
> buffer smaller than RTE_ETH_NAME_MAX_LEN can overflow the buffer.
> 
> Add a size parameter and replace strcpy() with strlcpy(), returning
> -ERANGE if the name is truncated. The copy is now performed under
> the ethdev shared data lock so that the name cannot be mutated by
> another process between reading and copying.
> 
> The previous ABI is preserved via symbol versioning (DPDK_26) with a
> thin wrapper that delegates to the new implementation with
> RTE_ETH_NAME_MAX_LEN. The versioned symbol will be removed in 26.11.
> 
> Update all in-tree callers to pass sizeof(name) as the new parameter.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> ---

Applied to next-net
