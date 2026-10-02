Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE3CA5FDD
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 17:18:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CB644026C;
	Fri,  2 Oct 2026 19:18:24 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id E3C6D4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 19:18:22 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a49896dd9dso82938a91.0
 for <dev@dpdk.org>; Fri, 02 Oct 2026 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790961502;
 x=1791566302; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j2uO+AjpGRMKPJby6pT0XrNotmJGzQeHNtOXvrcnem0=;
 b=Vi7jDnOM5bqB4MxFKt5s7iYqj+Hujt7jUpfX29atTF3ZdVBvuypmno1yFZPuqUeVG3
 B9XMfFf21oLWYJnTRzcyVaLSeUfHLMmBaiqzCLxtuFAW0CEhMLDhH49Cye41Kf1S7Pn8
 PzRlLIfjIXLxJvo067W0Pd1FhgZN7dNYJ60x90Yl75fF8+sXgv3P/hUUUKNAID5twpoT
 lWGbybMn/w8HlXNwy1dEbLi4yzU8yuTkt4yUiNdzMHWGF8/FgzfDC8ivRrafDOEv5/6V
 bIdH5lQXoIIpmkdA+LoDJ/QWnmjKEL/wVt6UEXG4kfWNGO3oe6cLlw9R+EBL5s01nFcR
 d4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790961502; x=1791566302;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j2uO+AjpGRMKPJby6pT0XrNotmJGzQeHNtOXvrcnem0=;
 b=bCiJmHvHdP7l2FqXsaEyV7RcF8dn7WS2Gsmwkv3DCM+eMO41wEybDbl/n6kN/FTJXN
 y957oV9yryLV/CUGEo9tSttflE1KjQzwzdGGPcE5HnFrMixrdFx1CYU8iwSDIEyxXzQU
 lYNbPaQEfQPtQXaKpjkYzuJ0IxFALjSPrWDTvOH8tQLaSx6/F25C9moDXffqQ5ZjPwRZ
 MbQkVHduRNOFUZG1SUXPbZKtQ2e4jRiSYbf4TRTnLBVLYCsz3ct8HYGAVNpfd9Lbr8GW
 jpBWDZk778SYRy+LWw/pTDNYw9zJCxH7Zn2WK6CtPvHWT7VdBDRGmDbtcd2bcubRPuDh
 5V+A==
X-Gm-Message-State: AFq9FYLGfFwxD2MZyWMu2ejGSfWcBjlXz8ksxENwI1RtCvn5MWUU+Xta
 dqAdGumuXsZHPe2fpUC2veZZSY0CVK8bZQ7usBLgzOju0wdMOPmgZ7UGBjH/lkhwHEI=
X-Gm-Gg: AYBFou0Tnx4HMgnVY4WCOMLZ7RWIt3uuHQ0ySUW84zIy1oW85k5rzuqxBgPUGKa+TqX
 GOQKqqlFVnjibz228yIQp7rq90QRU4LW15lMim08VFFgQ/sKloWlwOv4hK4k++mYPVC7VZwpJKQ
 NFMr2dq72Ux29sigPmOhBlJgt5tn/XBVnQd3IQi3Qu3oOogBasvLTD2qaQXAComzqoQtIKzhoVy
 xMN2rIcyCKovBwdj/8c7LY880DxwjqJyeJXk6dl25NItFEb55wLg38DxqkcLnPIglWkqxDhafqI
 tT87+vvjLLcocr180PBqPVtfRJ0OqIcGMd+2jo+l9fHUrw7Q0jMmWHHvvvofgkIWkUKD4R45Vh/
 WmIhV/hwJdxiIpcjjN8ZmcmDCDGlnCvpqWqru5IsITiwE3cr+HImUOnB5Gex830jfRvX92uopxG
 CwfyvuXE1VLAQglERS4/eGp7vLvv31Jm9T70IkQ0QC8dA9jE8qoCiyvPDPjOLHMMTZ/7DWaTUNK
 TYjssyNDw89jLqcw5XAiCandBI4RzaiU31Ju1yh
X-Received: by 2002:a17:90b:4b0a:b0:3a4:ba93:ec2a with SMTP id
 98e67ed59e1d1-3a6cecaf975mr1921496a91.43.1790961501971; 
 Fri, 02 Oct 2026 10:18:21 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6dca477e6sm2179984a91.0.2026.10.02.10.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:18:21 -0700 (PDT)
Date: Fri, 2 Oct 2026 10:18:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 0/3] ethdev: fix SFF-8472 calibration overflow
Message-ID: <20261002101819.528d44d4@phoenix.local>
In-Reply-To: <cover.1790935333.git.roma55592@yandex.ru>
References: <cover.1790935333.git.roma55592@yandex.ru>
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

On Fri,  2 Oct 2026 14:52:34 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> This follows up on the review of the SFF-8472 Rx power calibration fix,
> where the automated review pointed out the remaining issues in
> sff_8472_calibration().
> 
> Calibration formula 1 (temperature, voltage, Tx bias, Tx power) scales
> the 16-bit fields in place by a slope of up to 255.996 and adds a signed
> 16-bit offset. A result out of the field range is undefined behavior
> for the float to integer conversion; a negative sum wraps around.
> UBSan reports float-cast-overflow on randomly generated externally
> calibrated SFP dumps.
> 
> Patch 1 computes formula 1 in double precision and saturates the result
> to the field range, as already done for the Rx power. It is intended
> for stable.
> Patch 2 rounds the calibrated values to the nearest integer instead
> of truncating them: RX_PWR(1) = 0.7 is stored as 0.69999999 and
> a raw reading of 1000 gave 699 instead of 700.
> Patch 3 adds unit tests for saturation at both ends and for rounding.
> 
> Based on dpdk-next-net for-main.
> 
> Depends-on: series-39455 ("ethdev: fix SFF-8472 external Rx power calibration")

 Applied to next-net
