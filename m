Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C8CDB46B
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 09:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6D6C4065F;
	Mon, 22 Jun 2026 11:31:17 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id C7A2440150
 for <dev@dpdk.org>; Mon, 22 Jun 2026 11:31:16 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-51a116f468bso15083201cf.3
 for <dev@dpdk.org>; Mon, 22 Jun 2026 02:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782120676; cv=none;
 d=google.com; s=arc-20240605;
 b=F6uf7iGh6Igt8vOGr3WWQ+Nw/aNUGyCnGJdIM+0h5rP26uOECqhxuo6c7HbweGt1Dh
 +yonIn0SgT4JZNp9ewPZeI8Y/RM8+The39ypVteezvgI70VKjavyqkKAI256vGjo8Z3N
 jy0a+yJTnf3G5Ja3U8DevqBT5Qy9LBLdAGPzrSFcREHMI+bDAa6RbnF0Fl86mIcYm16h
 bb16BXRF9mx3cDP3MzMKo0pYiTPUgpJswn/UhXf6J+9PJ2pyFIZDB2MvjM7I5TQ+JiAc
 VqlJAQ1l2+ylQjvDwiZqPqKx2W555+DbPoDRiBmQ/lXeGfcgZkOKcTymJY4UR9o+8DUH
 9HDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=McSU380kM4F1SuXRKYqWlxogvUcpGm834JAQwKcXlNo=;
 fh=WxIU25GGxJWHrllu0tdry5uxQiq8wrB+prIK6e8EQn8=;
 b=l1ULpR+2Tuyae9wzlSK/ATdawucSCL4FWzutOkW6GE/SP6YVl53d2ePQoleJHZWSBE
 iUvdEvAR4+0kDLb2rLPPz0lcBzTVRm3nXQQ5EaW0+H1T+IMCRgXY60bt1+Ef+2iTNBeU
 RMnyzp4cPeOhlQfKb2T7kSNor7g7qQU+VCqRIKPwFP0OoqI63wTp5J5NdvCNEbH9bKgn
 dDH1sJgNe+QcEvs38TIAANXvWFLBn1CHutBPG68XA3QaO0cT40IykQE/vypeHi2DhqGr
 I3rlKQyWeATtbhDPzshZI5DjNREJjgc10cgzJ1qgl3XzzzmZfHkuzCAmjbghgIRX+Vjb
 JJag==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782120676; x=1782725476; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McSU380kM4F1SuXRKYqWlxogvUcpGm834JAQwKcXlNo=;
 b=aLJTnR3gnYGI8QCF/IZTeJTYDKHyLZOiJFg3O9W9pVZekJynxaSI0cR8s4yof52FEz
 mz2ll+c86ajXqkTNSfVcHHYTGTSM5DmMx76Ee6x7uvwTfcjlxziuUSexBMRJe497e7xH
 2DUCDZ+tabtb66KCZkN1Gzpbyd+AZH+YLif5BKQ4mJZGET9LctPq62TfZw2aTXqREFBg
 +xD0+nkNhAJCQ9x1mft8riMq4r08SKwnzilAUTEDA3PRRux261bgir+1J1GRQ4EwqcES
 n4yvreGnrh1cJXado1Qa9ACCz2eW/1zSiZ53CoS573S6SW3YkLlGUw0mKQacMWqiNNKE
 3LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782120676; x=1782725476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=McSU380kM4F1SuXRKYqWlxogvUcpGm834JAQwKcXlNo=;
 b=bzMl/+e7A0MY77ryB29qUUye4WvbhzxW805YyvihI3BSJbubMNmOjFuZqS8abktKi7
 59jzHOKSCdhfkjAY5m1k1xIC1Wrqfwsd13XY4ren3G5ojUYaXEWS1felwc5IJG95uyOB
 mUcGVIz5hUydhaEoXZPOPFXO4pu7rS8Etx6pPBdEVny+dLXD4nciFxpX5HhvmS8x6Uty
 vtE0pTTLgsA0gt3InxzAaxD8+XGYBRzLNP0dtTBp2iuRAOdt5wGZAN8x8+82jewYf+tO
 gfI6jpVmsRZLuVWeb7I/cMyOiTokzXb/s8C0g6Q2baAJmb17/Vkv+XJX8L62OJnjSdkh
 d8UA==
X-Gm-Message-State: AOJu0Yx2qYWpBVbCqrNXRCjyzrbZxk6ojXhqQz56CxdR5dlzp4QWeiWk
 678ExP3fDNi6ynyu25Xitds4MrA7BvY81C9J/B93UAv7Yv8I1/cOaGkj4n9buqH5Y/lrGkR/hh6
 XK46Hk+YfrV9BGl1Px5wfE+yg7h2zkwM=
X-Gm-Gg: AfdE7ckynvd5Z374Xld5pMWy90lZRFUPeOVQhNxuP8qqX4f8clAMeA3hhyGCWAkHx5X
 sid4o+jtH/Hz8f0n3nTi7N44UM4QrPUd9CEmz2sTXCQw1dDQwLd4c8HiBBIkxko0nHK4AS5BsNZ
 Dptbh/qqYZNPkqdwCcVjR53byf3vFViWUorfvN/EJ0asILTmKRRjT/vAHTBqbr8tvnZs68Rnx1F
 McsBTYHVff++1ovv7939SkXFUhTyQ9rPYcPklrfAAgddHxaLxaPjMr/vSQQK8cysOeJ
X-Received: by 2002:ac8:584f:0:b0:517:b750:642 with SMTP id
 d75a77b69052e-519e4dfcce5mr195790081cf.47.1782120675905; Mon, 22 Jun 2026
 02:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260609044202.936153-1-syalavarthi@marvell.com>
 <20260609044202.936153-3-syalavarthi@marvell.com>
In-Reply-To: <20260609044202.936153-3-syalavarthi@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Jun 2026 15:00:49 +0530
X-Gm-Features: AVVi8CdEjWCoNseF9XwU3xDkf4vXLzzPaL7aVztA8yY_1613uYJ9Q6eBOLJMQNg
Message-ID: <CALBAE1PNMsmPzfc-3rMRyp8ndoh9jCj68s=UizEv9mVqPJ3fOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ml/cnxk: updated checks for number of MRVL layers
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, sshankarnara@marvell.com, 
 ptakkar@marvell.com, aprabhu@marvell.com
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

On Tue, Jun 9, 2026 at 10:12=E2=80=AFAM Srikanth Yalavarthi
<syalavarthi@marvell.com> wrote:
>
> Add checks to validate the current active MRVL layers
> and increased the maximum number of layers supported
> to 512 for LLVM only models.
>
> Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks
