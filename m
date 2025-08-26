Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D9CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:20:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CAFC402E4;
	Tue, 26 Aug 2025 16:20:08 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id CA666402D4
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:20:06 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so3590372f8f.3
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756218006;
 x=1756822806; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZBphX/LfhXul8g3re/cB9HHr/Q1uQKQs7QGhBcSTIk=;
 b=tCeJzVp+TU4mLqrIv3bdqMu/rtmnQvcCRr5fSeXhYHQBJw4dr1vT3aKzOPScj3EH5r
 OWvjTJBqVfLTo2vyzF6Df9hfn3a4qT+mfFJsD46J4TNsrIYbDi6+v5DdbHkHIMhyElt7
 0jI7/4x4gLCDCHviNHBsPfknWbc+pUfzE+6MmdXC+frwt1r+g5PgIxfAPg4IIOauv3bF
 JKaAE1AF2HLi0JBa2rups3Hjp3K8ih8mJNdBxhgeJyd/w0fCEfC0urt64AYSU57swa9M
 tfS0JShCQZ/tzbzvtb2P2Kg7jSMibXKsMqzepylmiIUHzqsIxeFdTiC06fWSZYw2n0C0
 FznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756218006; x=1756822806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZBphX/LfhXul8g3re/cB9HHr/Q1uQKQs7QGhBcSTIk=;
 b=C/S8//FvKQlJQj7ylgzQkm8IXOExh5ztdTA3KuRRkqrhpglbt8eyeIQXxMw7hHakgc
 JJLC+eM0HyZ793+x4Dk7gFJ+zmFo2XE8/eYRJMpTEvlnwSp1Iz2ct4xFQRabNdrlaXt2
 1WucNsqPnY2swHXDkedzo3Iqbcoz1zh8Kns3NyaXFS9I40c79F6BqqNxL8RFyLen2obH
 /D4r++fuXu/SUzN/VI67ZJ/Q7jTB4MIqdh/jbDXlb9fOEXAWs/pniOWWLdfN5i3SVqVp
 Y+XmcXu7EYQnL6DgC/wiJkcwx0m8ncqBDuueY+moyHfH77qdpYbjDML9JAKLtpKMfMA1
 wGhg==
X-Gm-Message-State: AOJu0Yxef+4ocg6SxN2eOUL4feO/X10vUFY+PFJI4UuYfNgPzeAwoRaO
 /EqcWY3TOf4aXBibtu9DqKWjnq2BG2X7r5Yh4PkHB9cvl3FP1ZJPKUzJZCFvFTsSEZs=
X-Gm-Gg: ASbGncsqXoJ88fKHIDSHTlwxDCPWZdMMfY51D/9XFxOVUuPtbtY6wCVjJ29NHzSZN1x
 w0vjhjttr0Siv+RjuRCE41qb6TM3ZYujaA7vEmQtFJEqOXWwHXIDFi5jNq9HHfrMRo1QcjnpFw0
 iTtT5mcq4HrxbN90h2QRjj10mgnFoDVfCRzSnjMhq3WUieqEH3TAzwBpS8mMWL/JVUZdkSb5Iol
 gurvk1WGHaI783kFYVwI+NtXcz5ptpueg85CWYqonEV/ERO+oHm6ennrnc79aar5HyVYYVYLwfh
 /SKMWzkfMewA5wxS1/Q8GnNdccOS+JDqdEiTjPp4R3w/Kjt8MKg3ZeBVAZW7HA1Uev7VKYcAzor
 tZjolnpvBMlrv86X/wYQPW/W9GK6vGD+uIo4KzHoEx2hAIJ6uoedpqxMhuRxMymk/YY2mRkcjCF
 lCcqfUxNb2ng==
X-Google-Smtp-Source: AGHT+IHCEYrvD+FjPL6gic9gIOmf5wr4YFoGU9bgfB7C1lROv0UNbCdaxGLlbgQz7NwLBCdH/GNjbQ==
X-Received: by 2002:a05:6000:4308:b0:3c8:443:4053 with SMTP id
 ffacd0b85a97d-3c804434626mr6561122f8f.1.1756218006302; 
 Tue, 26 Aug 2025 07:20:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6300da81sm71276775e9.23.2025.08.26.07.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:20:06 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:20:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] net/gve: out of order completion processing for DQO
Message-ID: <20250826072002.449ce90c@hermes.local>
In-Reply-To: <20250826000337.3922883-1-joshwash@google.com>
References: <20250826000337.3922883-1-joshwash@google.com>
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

On Mon, 25 Aug 2025 17:03:33 -0700
Joshua Washington <joshwash@google.com> wrote:

> Both RX and TX processing on DQ were originally implemented with the
> asusmption that descriptor completions will be written by the hardware
> in the order that they are posted. In certain cases, such as RSC on RX
> and double completions on TX, this will not necessarily be the case.
> 
> Depends-on: series-35656 ("net/gve: Tx datapath fixes for GVE DQO")
> 
> Joshua Washington (4):
>   net/gve: free Rx mbufs if allocation fails on ring setup
>   net/gve: add datapath-specific logging for gve
>   net/gve: support for out of order completions on DQ Tx
>   net/gve: support for out of order completions on DQ Rx
> 
>  drivers/net/gve/base/gve_adminq.c |   2 +-
>  drivers/net/gve/gve_ethdev.h      |  20 ++-
>  drivers/net/gve/gve_logs.h        |   3 +
>  drivers/net/gve/gve_rx_dqo.c      | 135 +++++++++++-----
>  drivers/net/gve/gve_tx_dqo.c      | 250 ++++++++++++++++++------------
>  5 files changed, 267 insertions(+), 143 deletions(-)
> 

Queued to next-net
