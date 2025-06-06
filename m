Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E76C61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 16:23:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E30040283;
	Fri,  6 Jun 2025 18:23:21 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 24EAE40263
 for <dev@dpdk.org>; Fri,  6 Jun 2025 18:23:19 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4a5a196f057so43789251cf.3
 for <dev@dpdk.org>; Fri, 06 Jun 2025 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749226998;
 x=1749831798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2evOcX7cNmpI7ScU0MLSK4+5strU5vchAH2Up2Lf0U=;
 b=Ostzq0fvgIJLaAV5/PHVgDlZPCnWyX7EexEgRRjbwx/XylNw4anwJjLJIuE/TgESNh
 Ajrzzo9MUTKQfJhuk5xzRDszRFSZS4F51KYoIUiru9G5rZRMNRv/5a6okwQk2m+ll36z
 r4jVOUKt+zlEooKpYEazlVWIPrU7aFIWz5PdJMnh1Kg36OivA7m3+yzOWXNpuj9Nv2Y7
 YG3Cyl8EmiJCHgJJfH/tKHgN+YRwRoTBGFXt3PFUrKYhsJiawKTCRfoFmhGxfwyOwUj1
 1Iz7i83GFASwspjsoY2C9CDo8f1Q1MiyV64Vg0WEmMbt2dl5lurstIvzdu+R2WPfoVz3
 pwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749226998; x=1749831798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2evOcX7cNmpI7ScU0MLSK4+5strU5vchAH2Up2Lf0U=;
 b=Rd+YszqEoLm48fI3BcwGWP/bDl8SAiIhCJoCqP90cOGN0QiGU//lrF9820iknHt90W
 l299PnBmnudu5MATp7cJakeJckrj0f0msVWRmn5VsmcCpPMIdWTF7KFtl62TcXhPR89+
 uW8FYutd7zdn8KQtFsX9ZxwSeV3zls/xcyM2rVLO0M8pMsDeJReQF73ppaRFDRfox3Zf
 32dRtKx5rgFk4eV/gRV8CwykoMN2bNt1pn+hRuiiH7esVFSrBMUKv993dg78mewLnMFt
 ntziQVEHRw264sWeVjSewngibvbkkyNxXk3mGotWBjmRMYRLsTnnyziApQKrsmgOXIs1
 EJKA==
X-Gm-Message-State: AOJu0YzLk+XDnf3b3RHFdxsImfFQIrIwuGi8bTOVkUnwxBhi9Awgi4QW
 RXlWFdtsUV1H576jDiWYUrGqO+el6qA3JgEahHi4YNq6+WPtfUWRFVYU4IXGvMn4s84KpZ4ZcHy
 hEWFh
X-Gm-Gg: ASbGnctbemS/RQzvjrDkyZn/L2JGB0gWX4PppWMa9p94e3odv+vQPR9DVHUfLpirNPz
 TG9oN4HVmQAUu8TxRq7CHidFyVz3Icn5PjtCYSp4qs+VUBqhj/rPjCG2WEEevmtZJGLYb4YFYmx
 U/fKjvrMjGxNAoeKRWwtAwb1+cdW+zndXa6NYhXpHFBIQzhjQHS6eAHrEBYyGXFC0goNFb+L3Cn
 9919h+X3yTMDE+1h/Dqo9V3q1PEa70FH3HJ0B5OBfbTz8PvdOxZ7Dx4OI8xINQWfRE1Ub+H6PTl
 dSSMFx4Lef1lkB82RJ5FAuefpzL4KB7Wv64cRuUSA8YkMqumvZo0xIgDpGiBzQyxd1MLkAUwvzT
 Cgh4DteYG3aS7s34XBiUgtSh2D4vx
X-Google-Smtp-Source: AGHT+IEgkun5rI3Z3ZGwaclizghIexphEIjDLQBigz8mQft+XakHQXJMXtBou7L0Q4jA7Hds8eXoHA==
X-Received: by 2002:a05:622a:4a15:b0:4a4:3b41:916c with SMTP id
 d75a77b69052e-4a5b9a38b4bmr74726101cf.17.1749226998599; 
 Fri, 06 Jun 2025 09:23:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a619894ea4sm14420881cf.74.2025.06.06.09.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 09:23:18 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:23:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH 02/12] net/txgbe: refactor FDIR filter to improve
 functionality
Message-ID: <20250606092307.66f3ab57@hermes.local>
In-Reply-To: <2430F12A7223B66B+20250606080117.183198-3-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
 <2430F12A7223B66B+20250606080117.183198-3-jiawenwu@trustnetic.com>
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

On Fri,  6 Jun 2025 16:01:07 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> There were some defects in the original configuration for flow director
> filter. Now make the following improvements:
> 
> 1) Fix incorrect parsing to ntuple filter when set the pattern likes:
>    flow create ... ipv4 / udp dst is ... / raw ... / end actions ... / end
> 2) Fix flex offset base to set item RAW relative = 1, and convert RAW
>    pattern string to hex bytes to match the hardware identification.
> 3) Fix to create FDIR rules for VXLAN/GRE/NVGRE/GENEVE packets, they will
>    match the rules in the inner layers.
> 4) Support IPv6 perfect mode.
> 5) Add packet type mask to match more types of packets if the pattern is
>    default.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

This patch fails the checks for flow rules vs doc.

$ ./devtools/check-doc-vs-code.sh 
rte_flow doc out of sync for txgbe
	item geneve
	item gre
