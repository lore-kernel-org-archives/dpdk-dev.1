Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15412CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B3B4027F;
	Thu, 18 Jun 2026 17:22:46 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 7D3F840268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:22:44 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso170260c88.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781796163;
 x=1782400963; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fPZhKMJGL5oxqk1g/TFLdJXD+k3S0krkWpLGYtaHEyQ=;
 b=QCVHknu+1eYl4pRVlB3SKzgGunDkIxPwZOvJ2gNtwr8Ua241FRSGvAVjfyuIsKifXR
 FKRlDKYwXegf/wih7Cws5rHbrGZPpncNR7agZ163WY4Rdmh7t0YFayFh91YQERlBuflh
 0HKfa4tiSuGolmCAkekUnAo2hMJWt69sDBKSoEBOfafmWHxE6OrSzUOaH3ECvfx9O66j
 1i2JmGeuxVTKggkrw2l7JyUEAadSOTMXebQn91akHT5GeddbI4BYEBbtuQyi9aTSgDMl
 K6i0zc7wb9Fop8mPPxWs15l8G1Qd2OGsFR30D6COo2eRK2h4JW/dAkaJ5QjCl25zI5/x
 Wprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796163; x=1782400963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fPZhKMJGL5oxqk1g/TFLdJXD+k3S0krkWpLGYtaHEyQ=;
 b=KmQHro4m/uKLb2lnBl0jM3FfhEm3pDX1HMDagq05ontt+uesstov/b/J52xysj9NjC
 AJqOSIsAL2dqA9xS9AAsGjbv9gQgzp9hiBMSMAXWFUmv44opRzv7WKF9n58CExi/CZzw
 pmv82kwkIF8s6WAYVEQrtm1+rhfNjp0j0mpt9BTEiigxd68GRw9bJkZXmYAoQjOg4rK3
 9jpdcEqKNe7pS/3lf1xUXy+213O85qNZaN0TVG7NBIkRcgzGGa1gX88egYXk2XrYUQMt
 dKv2f2fNZ95HpdvHXTtisSKsaz5Dymt42tZQxHmToCADUFBxYiXbdonArOmAx/kAEGUK
 oFdw==
X-Gm-Message-State: AOJu0YxqLbcr5w7GA0iVD0NDjNY0Z7dNGA0406ZmsLTS9/Nn9d80nc+l
 WftCb7k/C6eS/VFHtXC0HuoEe99qdyRgr/Ye9HAgYKZPNHhZQuzxLzReannZWAwj508=
X-Gm-Gg: AfdE7cmteH0y22uUnVZ/laEVEIiUPwDYXYtvd76gt/Wh5YrhRIs7yUHOeX/82PuPb8M
 71WGTYenDgUqV71o/0R9LMy09QUTP+GFkjIlIkO1Llvfv86GlIbV4ZYkyq5fxV3jRb4vgPYK2T9
 XVKid4OdDHmai5u/PvowjSn5P01rS4ElZ1N73pMEjpQ/aN+X6xSgedPkhAVg/i3y5nRNIrbz7KL
 1soUtrwirzFkjoi4iq4ozO1O6FxzSOFmIoQkOhwhKEAKbmsQ9PkUe7baLbbbtoGKSKXz8Pl/+A1
 BKtdVcGcK/KUtFy54JIUFEKMZ3HPi2KkinQ9JgxecYEqEtRq7wdP4urnVTpphysNbZGgbloXFP8
 anC3q62gkwSP8brBNzeq2fGgkjFdxy/Y7pTkA7fWcznjpVEzYYBSvt3GtNuDIeDjUP1V7Dlc+lN
 7rBaKnWNvpnqz/LZFLpCc+jHMXMyMWsrHBpE3cKH26XlTsrQ8B4m2+Dw==
X-Received: by 2002:a05:7022:210:b0:138:30b1:4c09 with SMTP id
 a92af1059eb24-139a20fb4d4mr51564c88.10.1781796163124; 
 Thu, 18 Jun 2026 08:22:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b910c51sm18601594c88.4.2026.06.18.08.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:22:42 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:22:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, Marek Kasiewicz
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 1/1] pcapng: add user-supplied timestamp support
Message-ID: <20260618082240.517e60cb@phoenix.local>
In-Reply-To: <20260618143819.310046-1-dawid.wesierski@intel.com>
References: <20260618143819.310046-1-dawid.wesierski@intel.com>
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

On Thu, 18 Jun 2026 10:38:15 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> + * @param ts
> + *   Packet timestamp in nanoseconds since the Unix epoch. If zero, the
> + *   current TSC is captured and converted to epoch ns by
> + *   rte_pcapng_write_packets() when the packet is written.
>   *

It might help users if a helper rte_tsc_to_epoch() was exposed.
