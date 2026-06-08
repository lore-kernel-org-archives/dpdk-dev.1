Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95979CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F319F40664;
	Mon,  8 Jun 2026 17:17:07 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8284840265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:17:06 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-5176b9c476aso33404201cf.3
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931826; cv=none;
 d=google.com; s=arc-20240605;
 b=TCk48/2O4g47NZMrWJdOgHzp+aV6rJJO8PyhpSq+tDcz2SXx3U7sZHPHiorfLLOazY
 Xvdy0LGLhw9BbxtOga4sdRMJpT5s4ACafon1zqAu9x8BTdvn9GDQOdhEdazFya5HuPO1
 ZYJ84WlFwVNEsIH+QCHdfIS9oR6BtCUZrtMvDrudm5Dc2wjoZr8AdXsyrRgJwxCM+ski
 O4Mb/gjf7kpJElfGYb2HEsbHd9MqOeEX4UwkpvPq8aGIBNTL9i634Dw6oLULG3mAESan
 mIRIVsFOCT8RRfNpxneKpbfVi0+M8ESFgp/qAvdnYBm+Xi/PDbHJDsBtnsdnxmiKssE7
 iNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hNeWsFeXffs85wlPN8yhK+FEZlqCddZ/jAIWWnPNnIM=;
 fh=jbdx/Wceb3VPJjUp74ta5d4SFbwKBSOvSND22D5uqu4=;
 b=XXws5ebRg11E2xDhLuI9LeqN+YFPBvSRSSVYgkfUjfpwrzfOWTs5p9Coq92GKguxdb
 kPS/8AEoEqeXrJ9WiWtKG7wsZP49Lkvnmx/xaZ9BQ/2ztnxJkdYpUkd+zQCbfMK7ujgQ
 do44gAiZZy1RGcsIlzdlH6DeSZ2ehDIfOZ8Bytliiro0BpTgPNy1JBqo39OhnTRw17ps
 18sxNe7UA9jR7aIQAhDc5B9vYqpbXbL8fcT0CJoUsLYfP53yyeLHIG+vkkJK9Q9AwLlv
 WWy2uk5qZufHpZjQ0StOefL633AYne/rmEep4oRIfk5hRLhTsm31JZStGeXKadrPs8Ko
 SJaw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780931826; x=1781536626; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNeWsFeXffs85wlPN8yhK+FEZlqCddZ/jAIWWnPNnIM=;
 b=iyUBi0eG7hqNzckmMpNgq5n0nKi9HIsrvZa1mADhsWiTtwxqEROdel1KeuFlqZ7+uJ
 uyn9gNmGPu1v/5DnequVqfpQ6fmrLbuyPbrX0q71vTSnWk10t3goCOpIn1I8gO4C4nYZ
 adovs7zs59+rQd6L2a3riWfmKEHpzZf8MPY1gdPnRJkI+JuPI819G9PqVauztjt0MHOB
 CvECcrsRP077w9M84AwSgAE6fb6BxxgF5BhIycvpmy697cq8TB8O0t2gAevtjTM94fEQ
 sRees2EN0gjxkEnNtzsoBjiIux44NkrMzHoof8lAfdtdWv8D2PLeuxQs8VSFR46/A5Lg
 s8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780931826; x=1781536626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hNeWsFeXffs85wlPN8yhK+FEZlqCddZ/jAIWWnPNnIM=;
 b=LSrRQPceDTO0SaQjKIS4xiIFpvk4MAUI2qsPt9HGDPc1o5oKAdhDmirT68NI3xyis5
 cj1DtmpvtLevUKPFlG4o6Ev+eDzhlmS8ldQysTSKtjNmXGoaSUeJ/XnC33lDbYNfad58
 hgbcnPxT3ZHZPP7J8qFGZzNV7nDfkSwFi8yjoSiKD8joPtPUVWw22Lk3SemBhaRduDfj
 xENQf1EOeJaKHDPabvvWUeXMgzSnH1TMSRZEFpufE4qFDVrAcX6IzzoUxh2D/p1Y338V
 dl9sbGDvEXH6Hrbs+1jkn7LwceypzpN+OslOKLSnc53c9/dSZrY+Fwv1zTmDFpowR17b
 QQTQ==
X-Gm-Message-State: AOJu0Yz3eMLLv4NGpdc7sysxGDNHUmFhlR3FVPevQ+UjUjJxEd5XwOxO
 t+IQhMTPdkcsJ2OQrYpILGE0YHRUUxq3yx2mMJc4Alxw7Q+huv0LwhzF8Xaa3W1aBPxGzR6mgF4
 /lyFe+Z89aRDsrCwv4Uq8mP6e7LDWPgY=
X-Gm-Gg: Acq92OESEhOfQNOrXppggel6WtjLdDGx1IJG1cRKVSPehaAnRA6Uvx7/Go902LFWGel
 66PyQN7/zVIlFkJ4BMsJBCyJgUt9ndtAsKqCROqiWOvvctWj7TUpQvaQPitvuT3GCRZK+rgFFog
 JUHjSD4i6ue2/Z/xrkHF2K8Wqrqqx22rM8VC0hNEtKYXRmsHmLvVUX73uqjHGRrYL7LYvMRJ/gh
 pNHF7CdrPX+Wd4jvmDuJtusgLryOdk1Fu6jCT1XYbpBV7UseAMaAtT0PDaX17+LtqxWw79hQKvB
 L8xxj+l5fAuvDA==
X-Received: by 2002:ac8:6906:0:b0:50e:a1ab:67e4 with SMTP id
 d75a77b69052e-51795b9f0d3mr235887461cf.40.1780931825594; Mon, 08 Jun 2026
 08:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260331085529.1105898-1-syalavarthi@marvell.com>
In-Reply-To: <20260331085529.1105898-1-syalavarthi@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 20:46:39 +0530
X-Gm-Features: AVVi8CcRlCxyRRSmgTHcUGsgcoqXMvGnWnjPtANdefn2uYZE9chlgMyis0RB-dQ
Message-ID: <CALBAE1O6+cRJCef3CEC=MYs8vfBsr7eXr-RVP-_5QYq0kpHbJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ml/cnxk: support for 64-bit int type in metadata
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Mar 31, 2026 at 6:41=E2=80=AFPM Srikanth Yalavarthi
<syalavarthi@marvell.com> wrote:
>
> Added support for 64-bit integer data type in model metadata.
>
> Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks
