Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E85CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 15:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DB1642789;
	Thu, 16 Oct 2025 17:54:49 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 6BB874026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 17:54:48 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3327f8ed081so1200549a91.1
 for <dev@dpdk.org>; Thu, 16 Oct 2025 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760630087;
 x=1761234887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45AKEor0NOB0dSl9SyE2PTMbOsobfRmnA5bhCQfEQDc=;
 b=eVbjFC7hP7iLgN8hj4igd24TZTw9eoKs1xnv+M8KKamCgbBqlqar5FGLVHD7B5fjLT
 yDKNIfU7LDhxDgFRr60OBv2s5pUjOfhKlkE6YyZChyd/4jPOmQNCPhL85arqnbDozMSQ
 ZRA0C2GgBvV+9RqLpcD/htHubhC3hcocJWwc/OHnfoOA+JdOxXhfi1l60B5WaI4y3KBf
 skvSnJKRG3DX2gld5OoErGXJdo83saPJtGE4Viuez0NFtpNt4nH6zJd/EBin0hgsQ0cq
 kJJ5UPqXU28bp9dgYAomNdbfZeu5U/eDLhZahYbhIbHw6Ts+3PIJrO4/93iNiDMTMvTs
 BIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760630087; x=1761234887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45AKEor0NOB0dSl9SyE2PTMbOsobfRmnA5bhCQfEQDc=;
 b=IStQEMtrZonoQCtBJK6tnJ4/bhE+Rmgn7lynzNZAcpt8K34/rBdgy6SjFnayLM0kT6
 p1w1mNALbQY/fqd2xhdAcq3GvPkAsHVZNUtLllCzWpdsJzqkPZOXKU+VYgXZlppRAI9u
 NPvpAv7wYMInkLvKjZc8315jue1V4vaPdPBlwmUUOQx4/jrqSOAuAW+CA6C8CmdNgMXY
 E5sdPLb196+TzjPFrYnbIiz3jbxTz7GxZXG4AXmbeUJYl8yEcYQg6ch6fFnGl9JBojiw
 k9tDp/0rOAd7vr914BYZ+8ZYIk8kQG6ncT/8oLPJJcFdVc2YcAF6aiVnDmhMiusumwr4
 uKxA==
X-Gm-Message-State: AOJu0Yy/WeMpc55iGpsbW2vJsO/OImgcJKh1/oaLtpdZAVZBozds8nHI
 Y0zIDvAgAN7KFAknh/Kmlc/GHbGyzxeioqLtqGiuDAE0PaYZUKahb62h10Ye9I84akaoDKFPYfK
 jRrqOYp4=
X-Gm-Gg: ASbGncsMz2N9GprxMrdzWlWGyOYFilyZL0jMZ1vT8RExKHYzU6CbH9xuGjZn5g1XqTf
 d7VnqMIOAXMR3ELHrkSQTxPSYBWyLfh1SdOOq+JKHAj/AoXZDy3o0gYkfgFXulNFFOIsV+06JNV
 LEom7506rEKaXj7kS/kzjYzuSgEhEClcHhKO1yfZFQ0+xqkvQlmqVh3czQNWrTtN1psKCfvgqmT
 7M+QEbotfOf8BcSynlpjS/TRGAwEjMi9kryiF5YQZKdSAqScjaO+LHbrDy/j1fnFj8Ivjjr8P3f
 LYOKvVpqfYKCgELa/lMyUT3e2dJsx3oE5AFM6ZHMFTFed5DEY7CnJ7F3N6ZnhPlInqE2vqjrUXS
 C3F1pfKxSjw+xHLfoU2Uso6sB1JapCKotQdMXKPs6CB8/++m32Vzp+darw1QwJTBdJkiGQS9N3g
 1KeXq7yH1wtfMK1Ludgv+r77aKH24DZGeJNLfxTJFolRQFG8URED5g
X-Google-Smtp-Source: AGHT+IFh2BJclvC74QgZjasJ38V/FpaPDIuo8vpwnlUC/0ERpdCG7ybtMdXLZhFUNKy/aAc/Q3HK0Q==
X-Received: by 2002:a17:903:15ce:b0:290:b53b:7456 with SMTP id
 d9443c01a7336-290c9c93d46mr4966775ad.5.1760630087145; 
 Thu, 16 Oct 2025 08:54:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d35esm34499825ad.61.2025.10.16.08.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:54:46 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:54:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org, yaojun@mucse.com
Subject: Re: [PATCH v3 0/4] [v3]drivers/net/rnp fixed Coverity issue
Message-ID: <20251016085444.5dbe21ec@hermes.local>
In-Reply-To: <20251010070122.161401-1-caowenbo@mucse.com>
References: <20251010070122.161401-1-caowenbo@mucse.com>
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

On Fri, 10 Oct 2025 15:01:18 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> This patchset primarily optimizes the robustness of code logic and
> resolves anomalies in TSO segmentation.
> 
> v3:
>   * fixed no-lsc base api memory overflow.
> v2:
>   * Optimized logical portability per Stephen Hemminger's suggestions
> v1:
>   * fixed complie issue
> v0:
>   *:fixed the below issue:
>   	Coverity issue: 468860,468866,468858
> 	Fixes: 4530e70f1e32 ("net/rnp: support Tx TSO offload")
> 	Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
> 	Fixes: 52aae4ed4ffb ("net/rnp: add device capabilities")
>   *:fixed 64k tso
> 
> Wenbo Cao (4):
>   net/rnp: add check firmware respond info
>   net/rnp: fix Tunnel-TSO VLAN header untrusted loop bound
>   net/rnp: fix TSO segmentation for packets of 64KB
>   net/rnp: resolve coredump caused by memory overflow
> 
>  drivers/net/rnp/base/rnp_mbx_fw.c |  19 ++++-
>  drivers/net/rnp/rnp_ethdev.c      |  16 ++--
>  drivers/net/rnp/rnp_rxtx.c        | 118 +++++++++++++++++++++++-------
>  drivers/net/rnp/rnp_rxtx.h        |   1 +
>  4 files changed, 118 insertions(+), 36 deletions(-)
> 

Queued to next-net
