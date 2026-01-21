Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2237BCA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 04:57:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29E384026C;
	Wed, 21 Jan 2026 05:57:45 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 04AB44026C
 for <dev@dpdk.org>; Wed, 21 Jan 2026 05:57:44 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so40371615e9.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768971463;
 x=1769576263; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZHyu39OZMg7GAMhQs7Eap6GPtg2GWuaA/yBQgEwxKY=;
 b=PieLfzCLhM+338wh4YTfgwO6sywc6kW+2m7HPLpJTBJ1LXy2QSJmfigKbRB2r2vwf/
 s+p5oI5MVWc7FRUiwQdpsj4G/uYQtX+o5QC4bVIjOzcoqrhu0FhgTzE8l1Fx4VraHio+
 cDX2Zig4LE/ULl1sjX7FW+hmOe6RXpiSYmZJ57xc8f0opNg4AlqSs6ZRwwSDbYd2N2xj
 0awkCnxl5xSNwuItaaBDnjNzYxX/Pj0jqHtKq4ynCboimJBIqmWj2jRUwtMz3fdP8iPs
 /6oGmQF9eI2UrchgkM6XaRiUPu3BIDP4TQ3An76xB0CrLIpA5Vjby4+RDqcLfoMLdBQm
 PNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768971463; x=1769576263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OZHyu39OZMg7GAMhQs7Eap6GPtg2GWuaA/yBQgEwxKY=;
 b=MpmiQxc1JWpB6Gj4d4wUasPbJ85WPMFXVjWJzUVlyI0oyL8wPGrtL1Izf+2V+jagpS
 yXwdbZnEQ7vFAwuDH7ZVo5jyFw11QqDKpKituyBWLYdYviFgbbeT+KX6W1TaMRIvo8MS
 PIAwJiLbK2DNdnn2mgUURFyq2o8EINDytxLeZvP9vcqeISuNABOVcOp3Yh62dadVAsg7
 KF7PsKxILPOT+TlkmFIB40f0Yg0F3uoZE8ochH+BJj7z+4QYlpTSd140inE4fKUmPBME
 6AZ8qqT2Z2HL7LsZU3mApGw/+Rj8Mslk2EOYV0SJjplE9NmFrjHfaLcWePmuxcbnxeTD
 4IOw==
X-Gm-Message-State: AOJu0YwrdPk6ogP4qxnasIEta/46oJn1hAhrZq5i8G6Y65awGX6a/1+G
 GgEQ/IU5DQIUyM1we4BPKccUCdtNdVilyLI0oWWsFembyustEgvRKtRiB1jiHMSrpbzQoZoY9L1
 oZcH1
X-Gm-Gg: AZuq6aJ5SPiba/XqJIr+zHW/hPkjwgrYKy2N06oPgOTlE8FuqqKBoQx4L6zYdnOtxBs
 DgOMgB8nwuUFbdgxe91Jyi4cNqQyO+oOL6n7WjD3wzgkJdFDy4BRdiIZKnu0yrd9RyJluqn3l0A
 rU+Y1oEE2V1NUCAhZRYbVx9nrSOkt4HTBDLkGUThMWN7rkZ++sgEHOKBtT7cC68UQm639FghjeP
 Rx6khuoOKkG/k+w1dnw9HWh4wP4Nyr251v2HqmttdOpVdc0YhFNJm+3Kgzhz0OxPyv5k/z8oCxJ
 Iqf0IGv5UZf7AXvGFYrYa8sOwm6pKU41RTnQWn1g+9UVfuMKC2Wu1JCgKy0Xup6kh35MaMrjmgw
 qdqitZuuHEXTQYT2PlpRLWvHWtvNf90tmxIsT10nafOUuTh1aAqCNUmSqeTre5B4SqUjY4MV1v/
 +16j3qSCDoTS2IUSM8PHDfm6ueuzwlncC0cPQQoV8wObqZcwCBn8ur
X-Received: by 2002:a05:600c:4fcb:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-4803e78fdb4mr60608045e9.6.1768971463075; 
 Tue, 20 Jan 2026 20:57:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f429071a2sm336724195e9.11.2026.01.20.20.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 20:57:42 -0800 (PST)
Date: Tue, 20 Jan 2026 20:57:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/6] net/nfb: code cleanup
Message-ID: <20260120205739.0bb48b6e@phoenix.local>
In-Reply-To: <20260116152251.1467025-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152251.1467025-1-spinler@cesnet.cz>
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

On Fri, 16 Jan 2026 16:22:51 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> This patchset mainly cleans up the code and prepare it for another
> quite large rework. Also it resolves some unpleasant behavior.
> 
> ---
> v3:
> * Changed type of queue count variable to uint16_t.
> * Fixed wrong queue count variable usage in log.
> * Fixed another coding style issues.
> 
> v2:
> * Fixed coding style issues.
> 
> 
> Martin Spinler (6):
>   net/nfb: use constant values for max Rx/Tx queues count
>   net/nfb: fix bad pointer access in queue stats
>   net/nfb: update timestamp calculation to meaningful value
>   net/nfb: use process private variable for internal data
>   net/nfb: release allocated resources correctly
>   net/nfb: stop only started queues in fail path
> 
>  doc/guides/nics/nfb.rst      |   6 +-
>  drivers/net/nfb/nfb.h        |   5 ++
>  drivers/net/nfb/nfb_ethdev.c | 164 ++++++++++++++++++++---------------
>  drivers/net/nfb/nfb_rx.c     |   2 +-
>  drivers/net/nfb/nfb_rx.h     |  13 +--
>  drivers/net/nfb/nfb_rxmode.c |  12 +--
>  drivers/net/nfb/nfb_stats.c  |  46 +++++-----
>  drivers/net/nfb/nfb_tx.c     |   2 +-
>  8 files changed, 141 insertions(+), 109 deletions(-)
> 
> --
> 2.52.0
> 

Send v4 with fixes and release note please.
