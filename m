Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4829CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 17:23:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04E2743354;
	Thu, 11 Jun 2026 19:23:48 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 0E31D427CE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 19:23:46 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137dd523634so94210c88.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781198625;
 x=1781803425; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GmGAbAy/Yjfla/EDRMqit0cObB5+ILOMAXp8Ecdmto=;
 b=cFuWBHp4sFQ3rP7SAnObkEQFUxtIByfJoxuQoht16dIoHXz4yIcy/MsCltNLXHm5zI
 nOLWmuTiu2F4OoUIsDXAbq0E9VvKvqmzJvjWxP0HHZFKv/PpN43AqFc60mtqoiEg82Py
 kfwStqGXnwfb+2CuihysbnYkZ9Q353DV7Q3phP+BrKvmAa7JD4D9HbQYeZuj6pC12Z7k
 0EqHFd8Ewpt8DfCFnAHfMkUsEYN/CpeyvZONhzHgYGe6biB3SpJuHx/CoYxAX+qnQl5p
 1sitYhQsDTPEQxlK8+fgLwWCnucu0NFtfSqhHcpA/Qzqqa9iNWADfaE+V3KdU6g8H/dK
 1WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781198625; x=1781803425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4GmGAbAy/Yjfla/EDRMqit0cObB5+ILOMAXp8Ecdmto=;
 b=dLRUujQf/BO+OKTEZdhQgObbS3TlWk2pzDMjn/5UyON0A7LKqUe/kdstepYKLKap5V
 m1XtU+4IIlK3aUsNYG6daSO8dKSd2OF9MBSmOCM8N4p+CQBeSubTMT7HEfYXVj84bByu
 ZRwWlWDVas0MqBcS0fKkvYZnyiWm98gbdNvtCcSYgUmEtiy01eOc9+xMb1mIqNbpc/1a
 8qk7/j9BRqXm/vfLImKrBFEvKDiXpnQtqeiyY67IWlDGps49YZ/BwMrYagatK8MdXXL4
 637SKmVaWgSo8/yIV8hXNOYefDTPD1i6PVFcz5j2wWA63Baw5v3Ccs3i3sbO/eAX6a4Q
 Crgw==
X-Gm-Message-State: AOJu0YyhFLecZHLpqJl3v+1EkMLgyOdlqHnMgFkBIsqI9m7Z9/0EgnLl
 hAR3PmyWcPpn2WOte6NId9XAhUf1lp5CSH6FYE5Ep/1UvXBGuyQNWFRhwX/IA91DeCQ=
X-Gm-Gg: Acq92OEFBwxjPCJijsM22c8sHZQawEhWzEE3Icc+pu3SjTod7v5mEsFlol1ZoGhNpDZ
 y3qGIgIpBT+/JuogujEhCqdYLnD6es12VaOLb1u/SrhLhsW9doBUngB87fWeddoVXOLCPyrQAxR
 9nOA8pHmtzcDLC81910WZxb/hl7ylomolsQXh8tCZPy2EActsK7O+P9ARG2eHGUN9ILaFmN3qw+
 yse7MRsDxYHL92dZyLzQkSEYwK1eFruaQ1D7DoJ0gnj72C9o9FEp3gY1XvF/rzZOKI7Tt0vzdWc
 4lDUp+wBpJEONxsb4LTbQ77gkdvIk1Ip8K/6ql/MESoPw+4Wxl4bWr6BqHHWyJdcJX6lKiAu8Vz
 h27ZnfXNxhehVdchw8D/4YdnhOXFFcg9QhAqDrp6rt9mtuKX9oXNdtkutHpb54xJdZ0Cv/0LFh9
 LtaGaIFrWNk8QT3GswG4bZcYrxFrCQL9d9IdQPJRJXLH11kCYm4zZFPh+F98Bwb0gc
X-Received: by 2002:a05:7022:1283:b0:137:6781:7dd4 with SMTP id
 a92af1059eb24-1384215139cmr2429836c88.8.1781198625057; 
 Thu, 11 Jun 2026 10:23:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13842f92a78sm2534047c88.5.2026.06.11.10.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 10:23:44 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:23:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>
Subject: Re: [PATCH 01/17] net/cnxk: update mbuf next field for multi segment
Message-ID: <20260611102341.79793480@phoenix.local>
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
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

On Thu, 11 Jun 2026 13:02:55 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> As per the requirement of rte_mbuf_raw_reset_bulk(), the mbuf's
> 'next' and 'nb_segs' fields are required to be reset.
> This reset these field for multi-segment mbufs on cn9k platform.
> 
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---

Please follow code submission guidelines for DPDK and use
cover letter and threading of replies.
https://doc.dpdk.org/guides/contributing/patches.html#sending-patches

What you get wrong:
  - Please allow at least 24 hours to pass between posting patch revisions.
  - Missing cover letter to explain patchset
  - Use versions and in-reply-to. This keeps mail threads organized and
    helps maintainers track in patchwork as well.

