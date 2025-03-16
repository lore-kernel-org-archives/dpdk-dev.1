Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7011CC282DE
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Mar 2025 16:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C54940268;
	Sun, 16 Mar 2025 17:31:51 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 649BC40261
 for <dev@dpdk.org>; Sun, 16 Mar 2025 17:31:49 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2260c91576aso4311535ad.3
 for <dev@dpdk.org>; Sun, 16 Mar 2025 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1742142708; x=1742747508; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NqKBuCdgKrzREmf86DT5P2prlRXuSDuHmpHLCUF0U6s=;
 b=b/meWDwgo1/OM+4rzUzAYxhvpdcqjdHGyIny7fBCDZfOM6VHr2JTJIE90ehNd4xbtI
 2k8yQ7FB+gjIpM8LBb3x22aiCc5Y5e+DDp5cP2IkMK08q3ZECrIRJ7HnfZlH74sO2eII
 hs5sasc1JKiSZRbMVW0SAthf80gDMk6CCNFro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742142708; x=1742747508;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NqKBuCdgKrzREmf86DT5P2prlRXuSDuHmpHLCUF0U6s=;
 b=U8ZcFPU6NcCSZIasTm+IoU+DQcjUNmS3CaxQOZPG7GAH7pGQTevSTyXMIVVl7QKML5
 7gzNZokZipzOQL8kCrSjOwe6q4sJy3SF9+zQAKe5SM5Y2gpz7n7IFw/w4JdLg+ZTDdQb
 LDYftoMQAe+j/pO08/btrIijuoKu3llS49wUtGr7sCTS3XLOXDtixvpxkbMI5QTeyaGV
 qTdu1wpB+iwtcDNhTBnO8ZvYiUDLPwmA/a2uO6t2+1tdhrVdISd/Zz1tZBg+uZNjH8QZ
 66RXSyCCs/GeM/mRAaB1ihunT4dd/vgOTot3IZBkREsAn7TCLypiA0Mt3j1K02ZumBbt
 Ep1A==
X-Gm-Message-State: AOJu0YzRBMkp+TM4j3oy9sNwnKdHUBhZ+QgQLvYdJNW4wv95RED2iena
 7CfruRLOSx+3ZYNvWr3YIzqqFwXcInaJCJFpNzo7pmERNwbn3AURDfBGlzY17A2kNxNOiYYt3/1
 5AHo7lEWt8DS5+CRmHNBGkFoUxN4w76lebMEIuA==
X-Gm-Gg: ASbGncvkWhsKnJtGxxkJkrjcJjNUxI9Q91YNPQn/39TJgwp0x7MMDIr7nf2Jj9Vl50S
 vZsnAkq9fLiGZAT89XrDl/CTKFzxNzmXoBwr9/XnTHgb6qN5yr9AZb+nWv1sWeIAWEJqipgW458
 +Yo+MVQdYOTfc2XHvbqwN7sLqLAGwlF0iss5w=
X-Google-Smtp-Source: AGHT+IH8/hExs8GtVrEvYV12R5AkRrfPu6w3ncIH0rEmvG9CdIp2p9/y42cmcFKQwS1V2zv7v6ey6hNcQ69g5lamJA8=
X-Received: by 2002:a17:902:ef48:b0:221:85:f384 with SMTP id
 d9443c01a7336-225e0a3fbc1mr123767685ad.16.1742142708423; Sun, 16 Mar 2025
 09:31:48 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 16 Mar 2025 12:28:03 -0400
X-Gm-Features: AQ5f1JqOl-DIayxsSKXctPWICadEoPtaRmRkFvE0bG7giUB-j_8VUqYgXUc2CFI
Message-ID: <CAJvnSUDu+FdSc7YfBQ8jLG9yXFKq3=VWEui9orBghEBuv7USfw@mail.gmail.com>
Subject: DPDK CI Testing Meeting - 14:00 UTC this Thursday
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000048b8140630783563"
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

--00000000000048b8140630783563
Content-Type: text/plain; charset="UTF-8"

Hello,

The DPDK CI Testing meeting will be held at 14:00 UTC this Thursday due to
a conflict with a different DPDK meeting which is going to happen during
the 13:00 UTC timeslot.

Thanks.

-Patrick

--00000000000048b8140630783563
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>The DPDK CI Testing m=
eeting will be held at 14:00 UTC this Thursday due to a conflict with a dif=
ferent DPDK meeting which is going to happen during the 13:00 UTC timeslot.=
</div><div><br></div><div>Thanks.</div><div><br></div><div>-Patrick</div></=
div>

--00000000000048b8140630783563--
