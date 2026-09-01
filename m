Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBECC61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 15:23:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB9E64042E;
	Tue,  1 Sep 2026 17:23:28 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 19652402E2
 for <dev@dpdk.org>; Tue,  1 Sep 2026 17:23:26 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1167371a91.2
 for <dev@dpdk.org>; Tue, 01 Sep 2026 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788276206;
 x=1788881006; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3VHtMPf/dqZkLx3GpBQb0a5LRbmDpErdahnD/90MTHM=;
 b=0gZz6Q/iQRXpQGIbFsU7xFjKVOMMCQnf4eunkR0QzXt73DH2077/pA7TzPDrsvRoOj
 KUey9iOTWuX8P5Bx8Y6eL9oHOz8CDKumqNr0dxXLh/Ltl8JhVGLLRjc+UqMCkOapwG8n
 y2vBl3V72ssRhmhC9p1N5e7YkzqRw4SxT8zIAqA2f/n0MrzydZhG0/DXlNwWle4pltBf
 rk/y7KNXzP5eQVnYF14ZpoqXhYxtycFP5aVRYR6F+avCVm5rrwRbcjfKAv8y7wqwYl/b
 S36dH0fdcAhzcywxhraR4n5KQX3nRjvSK1SvNG+djA0BlPj1WqMVwsBmXSpxXAJ4P7Dq
 OeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788276206; x=1788881006;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3VHtMPf/dqZkLx3GpBQb0a5LRbmDpErdahnD/90MTHM=;
 b=Ojhlfe5zgZ4JL8m7uqQrAZEJp2ubCS0DC5L6FA3LGRCOXY9ugz9tm54BDrT76lWGPe
 p8/ildlX8CReB5F/MirKb5wWfh3IRIucZim2ADZ2tNF2twOZTgsMYGqUWK/L18SqHS3/
 zNYBN8CjIUtzL4Mt2E1XKRAE/L0ZxbihNrq5x0JMjaFyxlYo3aGxHF6PNFrkC8APTxlZ
 jpVhzMiLYEH7/iBQBQ77iNZr/kuLXDgjVAbCzh6adzSGeuOZ5g5ZnBEe0VRv3sZo62gO
 2/QAM/9dlE045vh9xSCpWVEp/YfpgtEg+khLn3I8Vqo+AeJ7p90ORYYiXQpHw1uzwTCs
 7fhQ==
X-Gm-Message-State: AFuF++m08rLauTnVwoOx6Qy3aqyU8pguwe/bUwltbLe0HBR2ro+QccMH
 0bMmN/7rlyLqlJSGxqMo1/ijkyXDTJtu2ywCr/aPvYzddhPSxHok/7loCmINjHBDYpniuHHKX83
 97Fhy
X-Gm-Gg: AYBFou13AJFoWdVla2TxXqov9qrxGx2e7yM3R8ieNjudIQEM7U6AxzaVrDh76K9wRCy
 XPD1mfSWhU5C86mAF14kI9VEK5qHfXJU2S5ucmWHLbGSK1Us3R5/OAVEAZotV5IYMhb17TTsA+J
 gOp1n5vcYSES/Ki6/+KDXF0J7HuSCcN2o2S3GG0gV8GNHtwNF+3XppIDZSqf9kkigFONkoehn1Y
 Yk+cSIEaO4NjNzFyYS3HTZkNARnhzpjMjfmNVfyQXS3OFf8Orj7gMSxph/XukqzeY0bONO6Sjct
 4dOKXgznRSeuwnW8AW6+Mr/3Jv7aVZaPqGmVV8QNj6DqpDWUm8y9+Y2dMEsgejK/foCAyzFf8ec
 eCZnOmaHJUW5AH0Zrgi+qV9DtnIpc90NZmdQonsq466Ryx+3H/haqBH+6hs3VW7qiuVlbApksuj
 S/z9Mdotf2mLCu5PcrfjNG4UEKo7mPAxtpWrRGkzKggdfFSD1P2mby4PqL7Q7zxcpIz1/QFqAVY
 e6kIMqD2oSSBQDRnqPAoOs9tKPeGA==
X-Received: by 2002:a17:90a:dfcc:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-396d0fd3a24mr56539971a91.11.1788276205727; 
 Tue, 01 Sep 2026 08:23:25 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396d2a73375sm7887726a91.1.2026.09.01.08.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 08:23:25 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:23:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 00/49] net/sxe2: re-align with reference and fix
 review findings
Message-ID: <20260901082315.587a5ed0@phoenix.local>
In-Reply-To: <20260901030511.3683235-1-liujie5@linkdatatechnology.com>
References: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
 <20260901030511.3683235-1-liujie5@linkdatatechnology.com>
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

On Tue,  1 Sep 2026 11:05:11 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This series updates the SXE2 poll mode driver (drivers/net/sxe2) and
> its common library (drivers/common/sxe2), fixing issues found in the
> previous version and re-aligning the driver with the reference
> implementation.

Overall the patch series is in good shape. I was in process of merging
to net-next and resolving a couple of trivial conflicts.

I noticed that patch 8 is adding a bunch of paranoid checks that
around dev_ops. The dev_ops->dev_close check is dead code:
dev_ops points at the driver's static ops struct, so if dev_ops is set, dev_close is set.


If there is a path where vf_rep_eth_dev[i] is non-NULL but dev_ops is NULL,
the bug is on the init side: the failure path is publishing a half-initialized
port. Fix that to not store the pointer until init succeeds (or clear it on
error), rather than null-checking at teardown. Please identify the actual
failure sequence in the commit message.
