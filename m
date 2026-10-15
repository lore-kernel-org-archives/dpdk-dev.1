Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239DFCCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AA3340291;
	Fri, 16 Oct 2026 13:31:31 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 6C3AA400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 20:47:04 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-15168a20b47so3837893c88.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792090023; cv=none;
 d=google.com; s=arc-20260327;
 b=oQk2IMMKCIIw6IRsjQACwvLZvt+yxHDXLLif0GXEvuX6IwIn9QB/1DKukIH/FBRX7v
 5NeXHx4J41qmk+jao/uqYwQP5yz3qskKGZpwvNM0JvXB0ejZinl+FwOUXtcnEC9egcns
 Zzm8DvNnuocgVyP0JPtEaL/gKvRaT+8dZvwFBglTIRtCNuRmkTRM6xSel4GPp5JgywnH
 0jWVBTeNL/7kofQwa9h4t1ej8nfrpOYntotlmt7+CD0a04+iWvZ6718i5fIgBjgjgGcv
 S9ez0PHTwJx8WV9F5+agW/xlVLpaLPH6YFoj9+NwUGEHflK//5WYBWvzGgfcI3kxHGJl
 vfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=o11I+gF63vw2ub+0aso/TOThRanLl8bqBb/S0n8N31o=;
 fh=/3extx/tuWUUB1JZhPCzbxCKkAa+EiI9c0dk4a0WapM=;
 b=jzLR5+VdQ9X5lE/c/TrTOu1wfygccqKgC8Y8DZwNCB9/f0yDFdlgM0KdBf+SUZCUp5
 luWMkKKhHQ00ezkdzLYrmmHZc8nDnv5aX8qStK/BtHsv6FKT5wam2y8P0dhfVo7pfc0M
 eH27noZwNFWPZPc+aPklBYdnC7Gsplc1opt3aN56bscIOxIF/ahTcEE/6clzMTl+yjnb
 loCJE195z5kvw/rnpuJLSiHcNSeIonWw/9uDc0/wnJRTOzPcMwNTAkr0HkpyHFJJvnma
 Ghq33eJWVizpfc9wTAiDFseNmaCyocBme/RI1xTLfgdVHlNpfkWEFntGtW/Xdy5C+eoo
 FYSw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792090023; x=1792694823; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o11I+gF63vw2ub+0aso/TOThRanLl8bqBb/S0n8N31o=;
 b=Df4ziQeZrBAZk3DN6IUIAlS+dHjIERuR92dfM4EL47Lj6saZyqZTJ66FdQ8fYFuv2g
 bfhdnRdYBxd2BAH42Qlo88ZVJI8hqy22EGYp2LlRFpz6DcUz1dmjPfXdOtdfhJI6eF1D
 Er/Sn/GNCXjFH+syXlzUjcrIleRCz2VWtkSr8ABgbq5pO8kdplRsxUcIXHzfmF5mGC0y
 nt2E3kri9RjPET0nMsSfH6/blPYvpU5UtCEnGg147QczLC1sPWHXGw13SxT4nxS/HP9e
 diJgv0gP9BgnEqZArQg3v3xDICKagiHXBAVLol9zf05aj0/PekuKkht7jdtD0P69Jtkb
 8Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792090023; x=1792694823;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o11I+gF63vw2ub+0aso/TOThRanLl8bqBb/S0n8N31o=;
 b=cqP4tszxhDwe5Y0Wvft3gTPZclcTl9Tv8tvhfS9lGRcrkLtmRdAsGymGldWhOsO0yh
 4iImUlQwYm70/OUe6VEUm1Jcn59IKBgBIXN4kMcsZKBPIRi7UlK/Iv8ZJ2M1i4aQ9z9Y
 tQhLCeiGSKl5wRrpYLQfJkyW8FWecmnvFgxLgNALSJp0t7nSVhj0wXK7bNTy7maJE5Kv
 UXyNI2aQht/VBQKTXcWIaTCx18s5m6NBmQYd928fqVeq14Cqiw5XnocRw8OJ/oVQApW2
 hH8w0LfoA6Rq5bXYLQr2UtJNIsLBi5/5+i2nq0hIwaS2CWHdy+IzqUWx3FjUq08+yip4
 uoFg==
X-Gm-Message-State: AFq9FYKDcWYOdSWIRIziqG++K3OueJhF7Yx1EXVe0JF+PU6H0ATcZOYZ
 yLNdw/z+uvEzLRPa5rZ7sTyg0PZ9qglZj4AhQ8hoyLYaPffD9R0vAEXmJ0pEaeGfALUiSzi25rH
 OXYSGcs8PB4NAZrMMzI8RNbBNLqjCb6kkKgZV+KA=
X-Gm-Gg: AYBFou1utQob6ZMV0aNn9wZ829vsWEqlPhuNSnKqXbhTffsl9+sD3G6XWDy2QYe6iVl
 FsmepRifBlOTfsk/b2BcFs+tKbup+IGgXIeFWKiwfVE0meLSritUOilscGUaP82bOcNFnqO7Jen
 GdWJvFM7+JUqmDvpCPhI4ZJQ4MrEp2owYbbG63pmTu+ovxhGJqC6xlc9q7z2/W59y+wKUuuJqtB
 TpTHHHmm9rydaJt8RWvJ/QSVGuAcIrfsnkkHuIyl7zJL4klnFWmoPJGcsFl65t3CnlrMq03z1mK
 0Tin0kZdpoCusli4oh2ahosO5SwpJ11RBG2oAmZeZWt5mr/L2Nk44A3BQi/qFqP7L11lJPR/k/O
 g27BnfcIr4bbFeNfEtNvUCrAD
X-Received: by 2002:a05:7022:b058:20b0:166:37d2:3b72 with SMTP id
 a92af1059eb24-16a5fc9170cmr27529542c88.27.1792090022978; Thu, 15 Oct 2026
 11:47:02 -0700 (PDT)
MIME-Version: 1.0
From: Nitin Upadhyay <unitin438@gmail.com>
Date: Fri, 16 Oct 2026 00:16:48 +0530
X-Gm-Features: AclHuK9mcIIylUs4IDXGbrLZIhCneguy6dr_AMCO3UI56qqESsHBes2K9bWmN3o
Message-ID: <CALUB8OP7m2zbN7YFV+_+BNHxJwrv+meCqaJPZSzynHnqcrpKCg@mail.gmail.com>
Subject: Re: [DPDK/core Bug 1970] fib: trie leaks a tbl8 group on failed insert
To: dev@dpdk.org
Cc: maxime@leroys.fr
Content-Type: multipart/alternative; boundary="00000000000039a6e3065de579bd"
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

--00000000000039a6e3065de579bd
Content-Type: text/plain; charset="UTF-8"

Hi Maxime,

I reproduced both cases from your Bug 1970 reproducer on DPDK main at
commit b618d731ab. Both tests fail as described.

Have you had a chance to investigate a fix for this, or if you'd be open to
some help investigating it? I'd be interested in contributing a fix
upstream.

Thanks,
Nitin

--00000000000039a6e3065de579bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Maxime,<br><br>I reproduced both cases from your Bug 19=
70 reproducer on DPDK main at commit b618d731ab. Both tests fail as describ=
ed.<br><br>Have you had a chance to investigate a fix for this, or if you&#=
39;d be open to some help investigating it? I&#39;d be interested in contri=
buting a fix upstream.<br><br>Thanks,<br>Nitin<br><br></div>

--00000000000039a6e3065de579bd--
