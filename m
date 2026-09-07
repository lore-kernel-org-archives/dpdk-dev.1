Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF25C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 16:59:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC243402DE;
	Mon,  7 Sep 2026 18:59:47 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id CD7A840262
 for <dev@dpdk.org>; Mon,  7 Sep 2026 18:59:46 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2d032846c95so40681845ad.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800386;
 x=1789405186; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ECKZeAvtYoZ5841QiRoDZUzbYeXHiYdoyAnj5SMUNg0=;
 b=rze3Owbj+MVP6LqdVJkNgUPk4yvnkGV4rEODpVmghpZ1fym60Dy7fwp8EsLX6Uywf5
 WlPHkn7Bb6Me2N4ILFRHDD2MdIzSL/BxS9ibFB00MYUeZG3rQlcPLEarm/ZXbltzmDGf
 VyVcXGqSWWNELFCOVCNWXbgcdY1imly60yIHfOAqRrlvEbTdQIzKExByeVLuDoobQCxg
 f7TuMeKsdu8t1KWzVjiHdGG6IbdGORcRsurjhc/d1gpc0ezR2yrbh1JQg8CHIl3Y+agQ
 M6F5HU4ciiMLsgnY91xiRp0yZ/xpZf3nVfKHcLhQEthPlnXwkJYckxk0yqcwWFDAzuZQ
 o7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800386; x=1789405186;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ECKZeAvtYoZ5841QiRoDZUzbYeXHiYdoyAnj5SMUNg0=;
 b=ZP5/7Lz/YD5RNf5i1M5dmrBeRPSfIqLLhJV7MEd3NY+CbEvrQffZHa8qPVq1m2ikIa
 nUIIYkCZ2kigd/HbFEnQTBiBeKhzLSRqZD+pDl2FlDgz3lpqzMI9Z9xC8t3OTUYwdk9c
 gwAAFfolPTwKAZ829mGSvFvAimwuhOWmp7jvNUrxw0YBUlP+px47x8slX0hBAsJLg1+X
 qAZvxoJuxlXoZlqoV7y23n8is3QQnNWGbIAmD4APsKi0woYbA3boC2UpgGQEqhFjAvAS
 WeHlidBK2jKaHkhyiMmmFMhZsQvW4IC7aoGLSKQMqS44c+RD08RiQnJLI6QBpP5zFMyZ
 Zpcw==
X-Gm-Message-State: AFuF++nYHdbZlBWQYWKtBB+FvoG2eomdZKkWU1zMvODxWygd5od0rfnx
 Agtp41CgHIjRKp2jD7uJ2NOQw+np4nUG3geYwiyunFPWGCHflD7pLbNHMVkMlY9/MlQ=
X-Gm-Gg: AYBFou3YUpRJ6s2/rsgCdJffjcNo2+sYJCyOlnboQTYmBVAziplTqq32dzqGjusEt0L
 ifjxnKcfFWjOx8lEHNWJ0zWxg2LaCSZpxaNBut0arI02n5AHxtdJeO9DjE5bwZfcEAAEIFVPdFu
 hjoy+H9Zyw55Eise7oGDqtyfBMcgRitckyBP3wlX8rUN9udnRS/FKJ2nEQeztCsdP2gKWlczi04
 Ku+RhUgUQkfCEyFjblDoVwVSicyb+BDIoA+aZ5BRZn3czPltT4KQb7gmb87PentOqiZ2RKFpdP/
 XdaH/nl5uJRNpgqT2miYm4hI0e3VP1vVTfYmR0I1gBlYNJIRu4uJS547yVH51LBekokbHVzY83X
 K9wKRemN1D0SpOnts3XbwFlJ2AhtPvO88l/Uf81u222VVKIlIuO/x3nY42ZJLQBNzVq2KUD7POm
 AgGEvuKOH/kHzXJmH6pAamW7/I/MSqzNkzWHhpDiELiinGho0dxOymP9ucaBkyEsnOD9cdazOwH
 ozVrHBhwDVAPgor7XUJEn9AyKKo7xlS9uHNawwN
X-Received: by 2002:a17:902:e948:b0:2d9:51b7:c0bc with SMTP id
 d9443c01a7336-2db125a3452mr387963055ad.12.1788800385782; 
 Mon, 07 Sep 2026 09:59:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db24ccb4a3sm38119315ad.36.2026.09.07.09.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:59:45 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:59:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <G.Singh@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v12 15/15] net/enetc4: add WRR Tx scheduler devarg for
 VF rings
Message-ID: <20260907095935.2e025e86@phoenix.local>
In-Reply-To: <AMBPR04MB12281ADC78B3A57B4DAC360A4E1B22@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
 <20260821055643.1359277-16-g.singh@nxp.com>
 <20260903111938.6164ae05@phoenix.local>
 <AMBPR04MB12281ADC78B3A57B4DAC360A4E1B22@AMBPR04MB12281.eurprd04.prod.outlook.com>
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

On Mon, 7 Sep 2026 09:36:11 +0000
Gagandeep Singh <G.Singh@nxp.com> wrote:

> Could you please share the latest checkpatch.pl script? I tried the one from kernel v7.3-rc2, but I'm not able to reproduce or see these errors. Is there any specific command or setup required to reproduce these issues?
> 
> Also, would you like me to send v13 after fixing this, or would it be sufficient to send only the updated patch:
> "net/enetc4: add WRR Tx scheduler devarg for VF rings"?

I use the replacement python version which since it can be in DPDK doesn't get as
limited or confused by kernel only things.

Sent revised version https://patchwork.dpdk.org/project/dpdk/patch/20260907165808.320840-1-stephen@networkplumber.org/
