Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C937CE7DF16
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:51:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 372D14027D;
	Mon,  2 Feb 2026 18:51:06 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 6F7DD4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:51:05 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso36316855e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770054665;
 x=1770659465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=6cqZlx7xUn0HOjJc/zy+HEyybCb+JdKFUxCYm00xVJM=;
 b=NWe/DuVRgFuOysjCeigFvIcu1yaGbMxajH+/F0BWlr3GogZgwlbuQS9ugeCi4AXcOB
 xqZxeioKTrZiwnBbySoNjt6uzUbRmsX9WRhhT1nJNqE/vOc/9LNUAp4NN4dbDShBme5u
 dMXRgUMK9PEBFobRClrUecrq0YuBIDoEgy9YEfATqxGbk9EB7uv9kt9HmEu+J8x2B8SN
 wsswfVBGJHyqac1pIwuiWLAOVHW0O0+nwXGaIPM77WLl0PySJ3LSqEMYRjd6012jAs2j
 ecQW+R/lyaFHneTzmHbuARUUvCPmfnNPSdUiUa4DDe+Zdu22nKKDlpeH3ejMCTsnxcj5
 aHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054665; x=1770659465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6cqZlx7xUn0HOjJc/zy+HEyybCb+JdKFUxCYm00xVJM=;
 b=t/+iptaciIpPYL/EuKFFAN+UQ4i+atVhVsyvScE1vJfJhPTTq6o+XxOU9VYGiUkSuT
 g3dByWMse1iepun5lAb9xP86pdt9zIJ8lywzLi2OBta/PwzgB53ODQTon6qErmbWGobs
 KsCud1J4DJzMzSkH79wluhz7eEbopPofZsFQjBUJpfISZ5v4jPy9VonMoUWh5Qdl/E5v
 Cnp1GZIgpl+pIDLQ1BtJniP67po76q7oIgacJ6Wz3qgc+xoYJRygm2kPTMgYe7U68eSQ
 mnC+ZiCw7NjuNvfSyW6gdczXjf7F5BzwehZCKrDElyTSYpCa4f7Y5hxjDwEVH9NXjI0X
 419A==
X-Gm-Message-State: AOJu0YyaqUuYcxorRXRv/RMED+7jXk1+fAHy+Rv1z2ICokhBZ9mqafkh
 eVO+LIowP5JiS8gjk/kvpJ4vybLloBjQYFXpxK6RAAvBe/oXhDo0UQRCLMh+9cudT/U69qH7shj
 nvhD7
X-Gm-Gg: AZuq6aLtxJFwNKDbuGkH4LvIdfBgdxdw9d337FGS8o/M08EGE1GRme6Hhneg8XQURBO
 GhbZIyRCIZba/Bke5LT0QHrt8uP2arj2jflkZ9zr9nJewxxEEoSz2j2tuiuE+e1ro540YKka6n4
 9bknrbHaNVb8hcJGTTsij4BLtrgEV/3C6mOW8gdo7/XVKYqYx45as79VDc4EbzHtQPI4c6eZ1hN
 /b76R0IrHDwfPnX3GYgKBuxcPvLwWRUuQGI5NhYzLq4NiolTtOcPbfIQWlR3bUmbAyyLfXk9Vj0
 gtJ181L3SgkeB/rJaCOQrCLU2hWDInZy+L17610gJIspmlLA0J4MM/jK97o+UM5JzA/JoccoNjb
 FA54tbJFBzhFQkyd3HczEZPzzWn3EHMbg03bLt6si8nH/rSkLKRsIAXOzu7r3C3JceFBQLsT3lF
 eH7au2D7+EbuldXRndWr/syqXpfVoeigzyOLOvnlHrxa4tiJbNj6NI
X-Received: by 2002:a05:600c:3f0b:b0:480:1e9e:f9c with SMTP id
 5b1f17b1804b1-482db45fe83mr165380145e9.10.1770054665066; 
 Mon, 02 Feb 2026 09:51:05 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483002955dbsm19388515e9.5.2026.02.02.09.51.03
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:51:04 -0800 (PST)
Date: Mon, 2 Feb 2026 09:51:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [REVIEW] doc/nfb: cleanup and update guide
Message-ID: <20260202095100.3c898e35@phoenix.local>
In-Reply-To: <20260202174235.20628-1-stephen@networkplumber.org>
References: <20260202153449.3295979-9-spinler@cesnet.cz>
 <20260202174235.20628-1-stephen@networkplumber.org>
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

On Mon,  2 Feb 2026 09:42:35 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> ## Patch 2/8: net/nfb: create one ethdev per ethernet port
> 
> ### Errors
> 
> 1. **`__rte_internal` functions in header file without the tag appearing alone on its own line** (nfb.h:89-92)
>    ```c
>    __rte_internal
>    int nfb_eth_common_probe(struct nfb_probe_params *params);
>    __rte_internal
>    int nfb_eth_common_remove(struct rte_device *dev);
>    ```
>    The `__rte_internal` tag should be alone on its line, but the function signature should have the return type on a separate line per DPDK style:
>    ```c
>    __rte_internal
>    int
>    nfb_eth_common_probe(struct nfb_probe_params *params);
>    ```

Definately a false positive, ignore this.
