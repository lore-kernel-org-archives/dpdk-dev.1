Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96945E66891
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 22:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D28D64027A;
	Fri, 19 Dec 2025 23:02:10 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id D338C40276
 for <dev@dpdk.org>; Fri, 19 Dec 2025 23:02:09 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-29f102b013fso28035945ad.2
 for <dev@dpdk.org>; Fri, 19 Dec 2025 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1766181729; x=1766786529; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XdQ5NkAZdpqyvEdKr7r6rfMLq/xKe2B6AJKuwYCFV5s=;
 b=EPCGT58xjQa/DYBbMonO4jYBp1z+NFsVuNEDbXj0fdYL+g7Fd1Y52aM8y10CFl6SG1
 R/iilQaLK9vp2p8fpvhMDmhSG50ZeCD9YIy7q5bc/IkhK49Pso5ffl2IpHwN96xjvJkW
 Xv0Tsz+J3QrYSCxWDOP/Z3nstsJ7MebTNSZ5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766181729; x=1766786529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XdQ5NkAZdpqyvEdKr7r6rfMLq/xKe2B6AJKuwYCFV5s=;
 b=KFTF/U7pSYbgO6vEopK4jsHCKubLXaZ36eKPUA+uljIaYA6wInfmfl0XwPEBH4FzMS
 v8etlS6wT1jvSdvQzMH6qujOkmkgpucm0nTmoV6JqPz7PzhnDO4uV4jy+n6BOW3ozHOR
 DaB9/4e6IlP1QombBtndWjYDcKiAudMh2BatZ3kzZW4GMJMakw/QumeP+6WjsKb9tR80
 AEG/X1kDd40TrWHSUqKnSPyS2kDGFHrv+SxJ6537JIuu7jshYgKieH2WSrEEr2H9/wEC
 /YBWBj28vvg3UxXDCIWj79eMA0pXEUPjOgRWlRgbQSv6iQGZY8yNjMx93dShGz8pTUcD
 MeyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8DiYQaJHoD667HyRNClcnmdLjhsFCqjoD92fKvJzC5iFCctYXeZhUjNscIGG9nqVrd0w=@dpdk.org
X-Gm-Message-State: AOJu0YzUhFDoVbmHdFllRjcbdPwC+KB+Xcpm5oDcEqTod2e6+319r7tC
 /tlsQiWOJ7+4WLzCLS9rXZWMPWKTaz/9QwjXi+8NH/L1SBMTUmlTdCHpoe12hIb4puYosVHVHK5
 +C3FigCvTo1/EzYrYyPeydCAdwJsEiMk+MaL69yF3tA==
X-Gm-Gg: AY/fxX4W+4k/yAxRHrVlPoiYI19V/zIvg1xxgni7dss7FmnBq2uvmYOaZ1Wl+2k2aq3
 YuXmii7+dI6t6LDShCjvif9MMCkkD00G6WjDoDCPwKQPz5o2taCnQA0VDHFYxvXpnWg4UMJqTb4
 wp0oelnlvHxW0Yt1ANZpYik4ekqoX/zQvQR6J4fp5o9SRyCndkH806q7JJGvXR7QFtWTSeGPVi/
 z5VXpGFZhC/gn8humG6dT26+FKY6BhZmWEttjoztgXERKsTnPkwj/sYchXaXUSthgoIHmD/48XZ
 9hJqV+dQrQ==
X-Google-Smtp-Source: AGHT+IFrEQ50BhnbL5yOB+du2O/0J8GRt18K+IJLcPM7Zn53LKwNm7u58Slpcez2PDDz5O685RrByJwUmQvI/g0EgNw=
X-Received: by 2002:a05:7022:4185:b0:11a:2ec0:dd02 with SMTP id
 a92af1059eb24-121722ebc42mr5574115c88.33.1766181728895; Fri, 19 Dec 2025
 14:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20251212210142.669766-1-abailey@iol.unh.edu>
 <20251215214049.694604-1-abailey@iol.unh.edu>
In-Reply-To: <20251215214049.694604-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 19 Dec 2025 17:00:17 -0500
X-Gm-Features: AQt7F2rrVSQ6FNHbTWZ3ZtNimnwXYD2bjsv51oKpCT1YgB8nx4_oyygoSkcNyyo
Message-ID: <CAJvnSUB-VkmZJOKSpemKFeSBOppxhFCvypgVK0e0aWqwy_PuRQ@mail.gmail.com>
Subject: Re: [PATCH v3] dts: show missing NIC capabilities in DTS logs
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, paul.szczepanek@arm.com, dmarx@iol.unh.edu, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008f58a30646553ac7"
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

--0000000000008f58a30646553ac7
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

--0000000000008f58a30646553ac7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance</div>

--0000000000008f58a30646553ac7--
