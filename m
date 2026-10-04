Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8C6CA5FE2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A195D402B5;
	Mon,  5 Oct 2026 08:50:23 +0200 (CEST)
Received: from mail-ed2-f5.google.com (mail-ed2-f5.google.com [74.125.228.69])
 by mails.dpdk.org (Postfix) with ESMTP id AA1BC40285
 for <dev@dpdk.org>; Sun,  4 Oct 2026 18:53:15 +0200 (CEST)
Received: by mail-ed2-f5.google.com with SMTP id
 4fb4d7f45d1cf-6ae1a06a347so1058632a12.0
 for <dev@dpdk.org>; Sun, 04 Oct 2026 09:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791132795; cv=none;
 d=google.com; s=arc-20260327;
 b=EQYdBymZoVwBDaU4DpKAreWG532oD+Qzq5YU41P5GBwnPIHG0zdz6qnM3twW9DkMzQ
 1Prk/Y+Q7pWGihkfILmTTNAlJgH0dvmSP4BeUAP7luvmQaolEh/211bUV4V+RpkBVWq/
 mGHV4cYFuAKh6rnzGanro/tm+RQ42UYzKtsEGlFXWHszYEKcLOayB3rAH3FqTKZSkGIl
 393CDuwDicT9PJzwir075xZh28LbJv/sXoCVitj9R+GNn9Vxfn9TVbDQQuI2/d0LcwTz
 9n2Iw9lI40gOK8s4S+/9Hdqs8Sxmpg0s5cs+tkd72FUhhDlB2pgZtLUsANA9xPCJtmhB
 6nEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=4IkpDwSssOrOPPbZP/mZ4cfFuMOBGx+xHLxT+q/5Xm4=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=Idr2JXqOd3mTgvAGkb7+ujHT/0oDbus0ITKEjXpNLcwSyGOkNQvuHRM4X3WfMTEoWI
 vAliMzw7Qu6vCkFsKIKtWfcSToFPwA3X99+AHF1c/Jmd60xW8XCdMgQwZMRoo6GZUEgk
 GU1/sGf7QZJyzT8DIJNyJRthDp/9hyCr9RWJcdPebWmEToMGmqy9Y3ccwwNd9cDEJUe4
 nsguxeeR+0xbcaththwYEU/xZP++kO+GnexExKLo7gkaPSE1pJNj0EJG6HXX2YnB40q5
 FPVwMoHWpfQkH32TuX0KHD6V4Z9/PgWOMDDkQjMEFRbDd1IPl2TYrOApyw/IXSpbqoPj
 K/zQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791132795; x=1791737595; darn=dpdk.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4IkpDwSssOrOPPbZP/mZ4cfFuMOBGx+xHLxT+q/5Xm4=;
 b=fZaWEs8/0Rxcx88EQYcuT4ULsPmJYJtKYnsa1A6SP1TigCRBhhQhWvxYDxPmF7J2jG
 B+XWZ3jYFxyL6AJaS9LW7PgTQ6TU3DmnYym0ATh3OAfm/6YW73BwTf5oVscMi7ZATUO+
 EjEBzwq/YLi6sICo7y1rBTVTNiIu8J8Qp2WP8n8U/nEfFXEG5BIoiN764rZijjlGAtBw
 5w4rYU+upu0hLFUCRKeyclyjDfC5c4ucgX/nUpFXFtNPY67VFweZuvHFzo0UF6xOMnkq
 T8wlcMjgBhRXV5u5DaCcXK+T3FXTCPC7vOUsJmdaowpgkOyyv5e4OTCa01b4igBLhyM1
 Ycsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132795; x=1791737595;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4IkpDwSssOrOPPbZP/mZ4cfFuMOBGx+xHLxT+q/5Xm4=;
 b=fbV963azuYk8RHEumi4wAfWY9omeDqiSA+xRQml6CgSPWBhDFo19qAu2J4kMf+yWKA
 ZRoYF+RxxRnbRQuFGZZGEG1CE/aCZLNwKgU4Viqoh+cF4z9KpE6/4EkZXCzKVxWoYogP
 WJ7vKNR9wNBehrZYj1bBRUCEd4b4qIDTPKZ6MFkd7Jr2ujOQoeW2EXMGZPrc36UOPPFa
 G6+xblDPNOBn7vZV538sWc6Gbr93gbyPkSx4rBhMk50FmqwcUEeHQNpQKIesyFF+mTm0
 IlyQe+r2nWJNxC0nN8DEcs7zZ5ph4K2ViZ9c5IHK6M3fv5oUnCunHqFsKQIaxqwYckeb
 qH5Q==
X-Gm-Message-State: AFuF++m8FtTVjmGOzrC0RzxtQD4Qj4WNk+SFUpSY/A9sK3lVGsfzdk2/
 QjMbfYBsttAhzTj1qJh2dSDxot65xBCaKfNvU8qCSDdj95pmQwZDaFhTpOT18pSAleAB3bwTyl0
 x6mMBYgCEaAcZEWbypRP+djIPsffypsZSf2Qe
X-Gm-Gg: AYBFou33frMo0KabzPWOIVvAEz0qQHhNNC3Lcf0QrymTyYg7mfpm0nEvnTqk6LLcKDr
 dF2pUc72LCuLF5YuH5b/jy3bgFelZAZjNEXa/Hw/zwzJk+IuoRfqgW6VyBY3VAsVYZnuwwZOZKn
 kq27t/nRJiLXi/1/Cf+0rdq6X0R5evFeNXMGECI8KrbBQD7eOMPJH5ftJxj4ZZsqzQAb6lGHO2K
 o1WGqk3CpU8jF4o1asiatqSFwLhDkbjXSpRYVkO7sT2nBWriEQQVOuLsrJWSM2jR9njuYYMi2nt
 EXC+86sJ0gCec3pyvuqPW/ggk6mOJyBux4ARcpC2KtLLzq4A+yb5SqK6mCAXmY0EWzHsRg==
X-Received: by 2002:a17:907:3f1b:b0:c2d:fade:e089 with SMTP id
 a640c23a62f3a-c2e4a7d4789mr688751866b.0.1791132794961; Sun, 04 Oct 2026
 09:53:14 -0700 (PDT)
MIME-Version: 1.0
From: Bechu Kumar <kumarbechu863@gmail.com>
Date: Sun, 4 Oct 2026 22:23:01 +0530
X-Gm-Features: AclHuK-Zr65PsYYc9BgWlLX-s4YJ0Z6hJu15DoemhUDSU5gqV0EhGIHG2O7-D1I
Message-ID: <CAAaJ--xCSwziFunriB1O74cqr+Wzut_0n7_jf3i29x=EGhBerQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] net/mlx5: initial design of non template to hws
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000fd44b6065d0699c4"
X-Mailman-Approved-At: Mon, 05 Oct 2026 08:50:23 +0200
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

--000000000000fd44b6065d0699c4
Content-Type: text/plain; charset="UTF-8"

Help chahie humko

--000000000000fd44b6065d0699c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Help chahie humko=C2=A0<div dir=3D"auto"><br></div></div>

--000000000000fd44b6065d0699c4--
