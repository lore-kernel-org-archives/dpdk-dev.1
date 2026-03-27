Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8161710BA435
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 08:08:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D895B402C5;
	Fri, 27 Mar 2026 09:08:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7DCEE40280
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:08:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774598921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPdYGe3XJbWRp9wToVx3czQkXYWdFvSftG2OB5HtUxQ=;
 b=J5iX0nEKM18us/XyWjr6AMsRY8F+3/jIg1tpV0mM1zFSHFe9dJt+hG9vvhPC8jM2l1Rh7X
 2Tz+Dri9fwTmcGnTs/FcgI+BmJnpf9q8yO8t0tb4unId9gTR68+VR9+yAAg3iOxAqeDs+X
 D0roUhMA3USF+AYZRKzj41k99fuXGjg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-vZs4234bMY-AWyyKmkOmgQ-1; Fri, 27 Mar 2026 04:08:39 -0400
X-MC-Unique: vZs4234bMY-AWyyKmkOmgQ-1
X-Mimecast-MFC-AGG-ID: vZs4234bMY-AWyyKmkOmgQ_1774598918
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38a27d3b22cso8663981fa.1
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774598918; x=1775203718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPdYGe3XJbWRp9wToVx3czQkXYWdFvSftG2OB5HtUxQ=;
 b=RJd79f0fao0p78XrtF74iv/CMxLSwbx+EONX+bEpT52ywn2PkqVhwwgw252BkWcnGe
 Dtp2pSMr8n8Td+O03+HLtFuapRPDWYHyTr2tOmsVcKYGpQkRUmFv+5ZEfzMQmfn2Vyk1
 mm732RxL/qKN45t+if+LB19gHHsK5yt98mRarU625wmxpP1HsO2dkZbqTtd/mJMDgRCj
 sQl70AFIUBbhvvnMQsZkPpzeWKM4ml0pnjQjhDmIRcKV6XG9gLlDJhwB2ba+31VAhG/6
 nzzTQ/iLcdJ0yuReVghr3T9b2z2jEFX68W7zSRRCdy48IvRdM7uYNRlcDc/Do9BRAQdQ
 +26A==
X-Gm-Message-State: AOJu0YxDPDpvzp4bOlE41CFRrrPacEtGYDx4kb0mcC/eidFSqcrAGg4F
 rZoDS2EZ8P4h4EIEPE+CGISD0JMmUVNX+M6et6mjtlUNreBK3dEAN2qXwm6/OL5iGX6p+A+7lvG
 fDTEmEqSw1H8BBZZiwrt+ourxaaT+G3OSxwbUl2HOsmTRoyU98FM4Bqz7zj3+SHoYUa7PWUnFHF
 ATvinWrlHOJ7nwKf0y6qE=
X-Gm-Gg: ATEYQzx9DWL9CXUCsToEdGEk3XgKaLwSQE1dJE/v3yCRW99dthGnG1nYa9KivP8vu9w
 ADKRmL5t4qg/Amfxv1IA0qqcLq/hp3aI3bB04803xr8AUqciZaExsFnV1zdLPg9a3y+LrgW48ao
 aDmRRt7SSEmNgOP4aAuNEKvJbLC3m+2ar21WK3LcZLFuuRHxZ4v2uxr5lbXqCvnEe1fNZPr97Ve
 NUpYlsk3ptS3zBXqIyfkSyoHJgwbelgXw4U+AVBXwDS1j1gpAmrW7sJSID9Jfwtcldl7w==
X-Received: by 2002:a2e:be9e:0:b0:37c:cf34:536c with SMTP id
 38308e7fff4ca-38c731b83famr4560831fa.3.1774598917607; 
 Fri, 27 Mar 2026 01:08:37 -0700 (PDT)
X-Received: by 2002:a2e:be9e:0:b0:37c:cf34:536c with SMTP id
 38308e7fff4ca-38c731b83famr4560551fa.3.1774598917038; Fri, 27 Mar 2026
 01:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260327041517.812223-1-ajp@marvell.com>
 <20260327041517.812223-2-ajp@marvell.com>
 <CAJFAV8xMNGOV9CPV4PL_TJ3PF69Zddz+D6nCZo8uMv8jqyHS4A@mail.gmail.com>
In-Reply-To: <CAJFAV8xMNGOV9CPV4PL_TJ3PF69Zddz+D6nCZo8uMv8jqyHS4A@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Mar 2026 09:08:25 +0100
X-Gm-Features: AQROBzB5Xr3axVF4Fa0cB009--UU3FTSSIhHMinfkW71UI-6pQfmbzi2bu0CIfg
Message-ID: <CAJFAV8z=Q-FQaJPLPBiJwNJ44R-cXPWxbjmQ2BgD+Rse9LqUMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] examples/ptpclient: fix format specifier for port ID
To: Aarnav JP <ajp@marvell.com>
Cc: dev@dpdk.org, Kirill Rybalchenko <kirill.rybalchenko@intel.com>, 
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 John McNamara <john.mcnamara@intel.com>, 
 Daniel Mrzyglod <danielx.t.mrzyglod@intel.com>, jerinj@marvell.com,
 ndabilpuram@marvell.com, rbhansali@marvell.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QSdqk3o54KxSXZLnAwHpm2X-TmUpc-orDlH_HQD4OmQ_1774598918
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

On Fri, 27 Mar 2026 at 09:01, David Marchand <david.marchand@redhat.com> wrote:
>
> On Fri, 27 Mar 2026 at 05:16, Aarnav JP <ajp@marvell.com> wrote:
> >
> > portid is uint16_t, use PRIu16 instead of PRIu8 to fix
> > format specifier mismatch warning with GCC 15.
> >
> > ../examples/ptpclient/ptpclient.c: In function 'main':
> > ../examples/ptpclient/ptpclient.c:797:30:
> > warning: format '%hhu' expects argument of type 'unsigned char',
> > but argument 3 has type 'uint16_t' [-Wformat=]
> >   797 |    "Cannot init port %"PRIu8 "\n",
> >       |                         ^
> >
> > Fixes: ab129e9065a5 ("examples/ptpclient: add minimal PTP client")
>
> Same as previous comment, at the time this code was introduced,
> port_id was a uint8_t.
>
> This can be fixed when applying:
> Fixes: 47523597ff6c ("examples: fix port id type")
>
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Aarnav JP <ajp@marvell.com>
> Reviewed-by: David Marchand <david.marchand@redhat.com>

Series applied, thanks for the fixes.


-- 
David Marchand

