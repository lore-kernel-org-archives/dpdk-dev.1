Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E02AF532C1
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 00:07:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C419340609;
	Tue, 24 Mar 2026 01:07:01 +0100 (CET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0E30B402D6
 for <dev@dpdk.org>; Tue, 24 Mar 2026 01:06:59 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-82c4b5dfe6cso710638b3a.2
 for <dev@dpdk.org>; Mon, 23 Mar 2026 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774310819;
 x=1774915619; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkMXaLvBV3KobpYgWiZ0ekrFEZjDUUJvuCYGZK2B9YU=;
 b=jBu1mKpRQSEDQw2c2sDP/8QmVo6uWpGW5BLSAYoPA6QoGRlN7RQWhPZBpXlimvi19f
 QX2v890GTsoRN6S5rQz2aKUsseO9Y1ctPi3UGFHHjdwmiG4gLCJoEUxrAVcEJhnl0yR6
 wxMNC+jAWxuhCfhMUPt2e55sFW9hZLq5Z9UEKJqStUd3hpPJkqT8lDRum3WnLbexkOtd
 NNveegu3vtwqy0vh3OKd/B9VltLD21P2YI0V7z+w+eB/J689vnz1zH91CXfBhEmRaqxS
 Kki19wD8EirZYx5DDgIoQ/oz/sLPpHVD+KmBurx6zLZo84p6DI1jhEYz+PQ88B/oGjio
 0gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774310819; x=1774915619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TkMXaLvBV3KobpYgWiZ0ekrFEZjDUUJvuCYGZK2B9YU=;
 b=lyhMrc9sWJo77XqbpUFXueqv8VwfOrU1HygLXFDdLJIwMwPreqpqFQhUj0vWOgWXKA
 xXFZff3/ENDpFnQUHqX8eIA1NCIM+9onNBsZpgEIjk3ulTz/1ZlSVh+dVyYvKPnmnwOx
 GU3OJioXNdbDamDIJKxKWiMhkJGrSCj4Qp5xknfIcElBT29iEb0NCLq8HMQeLfCX2def
 CV99Tdunpa9Utq8NLcO1KZCYbGT+nQMZycIoZsduiR58RsHTX3zppnk9WfDpuyXEjB/u
 wGOENZ6oprGoxyKFME2CsOCZOXe/fu8/t2LrMycQN2z/7375Od2r24BgDINic+l93scK
 SXXQ==
X-Gm-Message-State: AOJu0Yw3HLLQuNKDqe3gI8TpVAoSlbkkkrKdckX+j97qbm8cv2qn538j
 Jreb2GZhWMqYb5N0Bz/tS6eKiGFmvlshzcsJAiwytXXpJrFal4Vpa9X/qrM3k0c6cdo=
X-Gm-Gg: ATEYQzyvJs4TydZZ4xnk4BQcOhyj3wVFQkiDry4JPzAotXLBC3nL6582LUQnlpRtpXM
 ghIOwN0Iq82gYK1f3okYx92LHlfYmI//iWjy+icwEiYZ7C8ubBc6X9SpbnEcStAR6pCO0DTT3lO
 8doxFPsH7L8w0pQrnJvFJ2g395cAiY5AZwAmioOrE7KmV0EnVa6qFcL4dC+aIiItRpY7dvtXgr6
 /XxccitsUprof6FOsspvBqLiIg5GKIhNwJyEgqgvDdMm7gN+jNmDOmV58XeyvGeSG/ITAXY54NS
 hF6dZeWNQ/uWhnjXuMJO3H0HWfptGljcyakFS8xvgwLn3jbxMGZ+9dXbL55vHRS4ZlA84O8namH
 5EwWXf6+ujIKThb+EG0wiy8Nk2lMwiA66O8dTyaV01dGKyjB/CLVUDFw+VnXu52/XUWH9q63/IM
 992cMs9FOPDsiKidwmjhIxxsMNH+EGaNGTVTk=
X-Received: by 2002:a05:6a00:9510:b0:82a:609f:d49c with SMTP id
 d2e1a72fcca58-82a8c35de95mr11074476b3a.47.1774310818841; 
 Mon, 23 Mar 2026 17:06:58 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03aa9fc6sm10939363b3a.7.2026.03.23.17.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 17:06:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:06:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, fengchengwen@huawei.com,
 aman.deep.singh@intel.com, shaiq.wani@intel.com, stable@dpdk.org
Subject: Re: [PATCH v5] app/testpmd: fix DCB forwarding TC mismatch handling
Message-ID: <20260323170650.1a6f24f3@phoenix.local>
In-Reply-To: <20260320062954.2042887-1-chaitanyababux.talluri@intel.com>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260320062954.2042887-1-chaitanyababux.talluri@intel.com>
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

On Fri, 20 Mar 2026 06:29:54 +0000
Talluri Chaitanyababu <chaitanyababux.talluri@intel.com> wrote:

> Fix DCB forwarding failed when the number of TCs on ports is inconsistent.
> 
> When ports have asymmetric TC configurations (e.g. 2 ports, port0 has
> 4 TCs and port1 has 8 TCs), the forwarding logic iterates based only
> on the Rx port TC count.
> This can lead to accessing invalid Tx TC entries and incorrect queue
> mapping, which will result in a SIGFPE exception.
> 
> Additionally, the existing VMDq pool guard in dcb_fwd_config_setup()
> only checks RX queue counts and does not consider the case where the TX
> port has no queues for a given pool/TC combination.
> 
> Fix this by:
> 1. Introducing an effective TC count using RTE_MIN() of Rx and Tx TC
>    values, ensuring forwarding only operates on valid TCs supported by
>    both ports.
> 2. Updating the loop condition to use the effective TC count instead of
>    only the Rx TC count.
> 3. Extending the queue validation in dcb_fwd_config_setup() to ensure
>    both Rx and Tx queues are valid for a given TC.
> 
> Testpmd command to reproduce:
> 
> x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-20 -n 4 \
> -a 0000:31:00.0 -a 0000:4b:00.0 \
> --file-prefix=testpmd1 -- -i --rxq=256 --txq=256 \
> --nb-cores=16 --total-num-mbufs=600000
> 
> port stop all
> port config 0 dcb vt off 8 pfc on
> port config 1 dcb vt off 8 pfc on
> port start all
> port stop all
> port config 0 dcb vt off 4 pfc on
> 
> This ensures correct queue mapping and avoids issues when switching
> between different DCB configurations across ports.
> 
> Fixes: 1a572499beb6 ("app/testpmd: setup DCB forwarding based on traffic class")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Applied to next-net
