Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7278C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 11:05:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4D9840299;
	Mon, 29 Jun 2026 13:05:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B2F164021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 13:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782731116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4aUyLUPp2KqylTcCy2HWaP/0gc/PTbP9pRqHsNEIdxw=;
 b=KXI8WYbMrBZkWkkIDfIiTWMyb2s84cBAypkDfJNyOIWwAia14YK8z5He4+wR1uWqvatbTI
 1X93fBw/KZzHRc7HK4Vjxxgq9lpZi3HsrBxlmoqnY93uA9nWGQUG65JRKPOUh/rsMfDwuX
 AW2oDmQEhTX3PTN9LFDYH5LAYLtySV0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-vVw26DtNMwiOL-lvrBMa3g-1; Mon, 29 Jun 2026 07:05:14 -0400
X-MC-Unique: vVw26DtNMwiOL-lvrBMa3g-1
X-Mimecast-MFC-AGG-ID: vVw26DtNMwiOL-lvrBMa3g_1782731113
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39af889f409so5488111fa.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 04:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782731113; x=1783335913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aUyLUPp2KqylTcCy2HWaP/0gc/PTbP9pRqHsNEIdxw=;
 b=Ty3lF/4zyfcX6yR2aEwyskmSaOcLUF5Wzs/GFQZ2AsvpZfcDP6sp+IdfSwY7Wg5O6k
 KYyBw3liMx3uh4dAhu5Bay5mL4duYiPMkfGi3y5EBaL0Dck0lAiElBiZhDajNF+UnDWV
 wflkta7E+962mp/ir2XUw3skQLSZ3TXCkzuONnF4hBCNQryZuUpvCiMBpMsdQltyHRjJ
 80GaLLu4yYKzYcsxtRRLoIawNh8agzN1T4j2ARSvhvfi1RGQUOjN1KZ25S/PkrjLDjP2
 +cVNF8N42cPUocpaJrD0V4rXo6DEZf872fxQPo+T3N1nEWY8oSDP1mlmtYe+oNKkAwXL
 fWNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeWX8QnebIZBBMiQCVRA3y4mwPWghNwENiDy4fuWtKhf0qSkf/FysmbOr/kFY1vB2nMaE=@dpdk.org
X-Gm-Message-State: AOJu0YyEIkkfX/7nrvoKcq4bx+mIR1/9ut0gMRpNE+zkNvuX682WBx3G
 RcF0HsfafErYYrEHle5wN5j87UO51+RcSbCHl4d9QtFm24Qo7gyrMfmpU8oksKzWjQZt/z7bWFK
 gguF6LySXzgVNU8fWKg2hE/SsGeqlTAuAq2FvlqM8RNuEXLDIC3mdWdXCe5+cQTasj1grGEFEeB
 yW8amukREjpzWKCNS1les=
X-Gm-Gg: AfdE7cmYl6NfqqhC5qPxQ7K6ZysgVFUK7Ahu6Vynz2CpJFq3vVoqhunmWO81G/MUE8r
 MF4KmsEH3fVuIAffL/106ZnYHHlZqhHvW7j58vUmMrIVkJDTXbvsMs5ezlW+SbeF/OR/2p2QyXt
 0tCFQVoGgBUYCuAX7pDKcJhYGQ8n3aL72MmX1F5NCKkvNt8VcUEAlqEFaG2tUSd1xApdMkn2yLe
 U3Na9vUbtpCN8hh9uk69FMQrAVErVAed7QmaP6Lfe0tTF65IrBdpaKuwYo=
X-Received: by 2002:a2e:b88a:0:b0:39b:d04:b783 with SMTP id
 38308e7fff4ca-39b0d04bef5mr5871521fa.20.1782731112859; 
 Mon, 29 Jun 2026 04:05:12 -0700 (PDT)
X-Received: by 2002:a2e:b88a:0:b0:39b:d04:b783 with SMTP id
 38308e7fff4ca-39b0d04bef5mr5871461fa.20.1782731112373; Mon, 29 Jun 2026
 04:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260609050020.995268-1-syalavarthi@marvell.com>
In-Reply-To: <20260609050020.995268-1-syalavarthi@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 13:04:59 +0200
X-Gm-Features: AVVi8CcfYvlQZcsitIAQFmeZXlo0-jVLy56mYamATHvCfNjeNiSqMEEoIJM-Gck
Message-ID: <CAJFAV8zof1hwMGJfzWCUYsr+oPwtfbKwub+ORPj9GSbqdiZncg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mldev: fix incorrect captions for model_ops
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
Cc: Anup Prabhu <aprabhu@marvell.com>, dev@dpdk.org, jerinj@marvell.com, 
 sshankarnara@marvell.com, ptakkar@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qFdTuOuTZhQrGb-FlO-eah8vgP_qFouOlaRPuEBDgL0_1782731113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 9 Jun 2026 at 07:01, Srikanth Yalavarthi
<syalavarthi@marvell.com> wrote:
>
> Fixed incorrect captions in images depecting the
> model_ops test flows.
>
> Fixes: f6661e6d9a3a ("app/mldev: validate model operations")
>
> Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>

Applied, thanks.


-- 
David Marchand

