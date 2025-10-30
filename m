Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB2ECCF9E3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 15:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4A254026F;
	Thu, 30 Oct 2025 16:35:32 +0100 (CET)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44]) by mails.dpdk.org (Postfix) with ESMTP id B177240150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 16:35:31 +0100 (CET)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-3d199f29161so965340fac.0
 for <dev@dpdk.org>; Thu, 30 Oct 2025 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761838531;
 x=1762443331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=duFLzUJcnaSVqe/ng0+l31kduX+gXG+OP1P66LE9ZPk=;
 b=yUa+CGcKhWHOw4xokH7/GsHCeIUOleSLE5pCQ7TCs2XgfLBQ+kkzuHpQiWVeWe84Bk
 P8KphZ7XhO8/w8VCTgCiUOlhapTvLs0DWoRtvT7EnhMRVYVlRdQTfHCKRrAGeicqbn8I
 dEKK33w9qkgEJpCGGUId2uMRmhigr8FO2cevQ//AQYmoIxVu+opum8ayh0qiKqNrsqHY
 QAR0Twp0yyyXfUQyb6DmI3NOnvlgIuFY6vKm7kLa7v/4LE+ATPo/VvG66G2AhjVn+30Y
 Yfs11kFjH1Psmpdh5KDgkjCkU7quh7G84dSK5TEpgGMYE2wYXr/Ub8XoF/jIA6+olWgQ
 w/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761838531; x=1762443331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duFLzUJcnaSVqe/ng0+l31kduX+gXG+OP1P66LE9ZPk=;
 b=GJaiWIgyXplUdxHKD2fCpzliJEEGivf81ib8FmdOMZNC2jiAyCiYNk+lgE9pWVyHhD
 jaZ1OYZjS4zwpWLciXwvP54JBQdLgNcfDZIhNcY+QrbUYJdi0JaLAUTRmx4vL4i7Tutw
 NsnuofnSUVciMGY1NdOYj9kzRfPGkv3atDe2Qlj2Sltudh80Mn0zLexuHI/E/SFzLiNA
 rxniEA+HRrwvmNP+9eNUYacqngsTbeVbA8ieY/Aq94peWA7XwCAGznX9qrPFzNdcNMhG
 FVOS7TwOzBuGQhuZi4b5Iq8TVHVYRS5ZnIfM60WyYhtjqQLOVlv+IvfHXgyrgFRP5ROL
 7QbQ==
X-Gm-Message-State: AOJu0Yy5AJlrMm8H+/tViAexfiCa62dESiz5Vrx9sjPPMooeGPY6MaY3
 uo4rSbWIzHwDYDDVzbUinbfhl7eH+XX+kkPdeMLdpoEDZNUuMgrJwmWGD7j7W45bIHm9PMXGeWY
 a9G3y
X-Gm-Gg: ASbGncve/2Tryyxcy1cPKe79bZHXKveoRCpdjXHG9gq/yGbPBRSLJ/PEaKa4jx2Hx5d
 000YC+FARNN8XNeEJbwkVnTu3nBbAcEsvqBAA1Pj95HRSyOf5Ky0zs8iO8apWY4fspNTiFnvh+R
 Ovwbg/RoPcLGsa9GKAaGmV5xdP3Btl7nEcKVNNya3oX8RoTgfjGl4ViNSIDQM0YUYBEK1nKnI+w
 nLG3fkDHY3L9FFlUywyvuoRi2i6iJ5d6kf9ewjlNhE72/m1ySJMN9Wk/cqDiEJnAZAJ7Xqq/A9s
 WfW7nV13nCuIHfmHvW/ot1nnFSzXRaJ93pjWguLdY+YehGO8CVU1qI2+470WbXO84EtCqoAgl6h
 xRKEmxtH1BeJlSqy2w37YUXwUdbv9q5QQ2EduzbJgEs92KiA/7ziuAkr77RCmyQoDmhuGTbFGSB
 lTdL8lR8xTpIJdEBtaqidjiengp+P3uffHWsL5zc0EkCtl
X-Google-Smtp-Source: AGHT+IHqq+xd3wr9FsHvs1ysJKcgIaCYMMcw2dAoB1U9I81KWwr+c4sHZ4BkUR+vkYd4cCe1Wv26+A==
X-Received: by 2002:a05:6870:a352:b0:342:6d27:2e2 with SMTP id
 586e51a60fabf-3d8c902d667mr1641451fac.29.1761838530632; 
 Thu, 30 Oct 2025 08:35:30 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e35443dcsm5915057fac.19.2025.10.30.08.35.30
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 08:35:30 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:35:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: retest
Message-ID: <20251030083527.49d149d6@phoenix>
In-Reply-To: <20251024025647.1563088-1-chen.qiguo@zte.com.cn>
References: <20251021065607.1418203-2-chen.qiguo@zte.com.cn>
 <20251024025647.1563088-1-chen.qiguo@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 24 Oct 2025 10:56:47 +0800
Qiguo Chen <chen.qiguo@zte.com.cn> wrote:


> Currently, various testing labs perform CI testing on new patch series se=
nt
> to dev at dpdk.org and report their results to
> https://patchwork.dpdk.org/project/dpdk/list/. On each series on the patch
> list, the results appear in the test category contexts for IOL (community
> lab), GitHub, and LoongSon.
>=20
> If a reported failure on a series seems suspicious to the patch submitter
> or maintainer, then there may be an interest in requesting a retest on the
> series for the failing label(s) in order to verify the failure is not
> spurious or a false positive. This retest demonstrates to the submitter or
> maintainer that the failure can be reliably reproduced. Unfortunately, at
> present, the best way to accomplish this is to reach out to lab maintaine=
rs
> via email or Slack. This is not ideal for developers in need of quick test
> results.
>=20
> Going forward, CI testing labs will be implementing the option to request
> retest for their respective test labels on patchwork via emails sent to t=
he
> dev mailing list. This feature is ready today for labels reported by the
> UNH-IOL Community Lab, and will soon also be an option for the Github Rob=
ot
> at least.
>=20
> In order to request a retest on your patch series, send an email reply to
> one of your series=E2=80=99s patch or cover letter emails with email cont=
ent of the
> format used below:
>=20
> Recheck-request: <test names>

