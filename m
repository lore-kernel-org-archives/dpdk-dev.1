Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6895C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 17:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0F5240265;
	Tue,  7 Jul 2026 19:47:18 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 1AF2E40264
 for <dev@dpdk.org>; Tue,  7 Jul 2026 19:47:17 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so7941825a12.0
 for <dev@dpdk.org>; Tue, 07 Jul 2026 10:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783446436; cv=none;
 d=google.com; s=arc-20260327;
 b=H9IdOyaQgvyXgh+yr0V+Y3Yg/djXW+5TY3FcQPbdkzGyUQPDBVd6dgZxKuevRfC64Q
 DOi6DQBdRG0c/Aoh/knPvqVnBVhZDIYDjKpAijfhFip5q7mLF59Y6r2ogTbKhxB2J8lr
 jZjvCmcQtp67ENoGsiLjCxJ8za8KY2J3zYZ8Sm/xFcCpBuUE6OsWsTTpkaZLq4wb/uIC
 Y1us8A7qHG1rf0YSvOKzICyu8m3IrGimPubWjbGbop19ZNd/yNWUjncGUNHPXU0fkTNm
 ULA8nnmhJIFPd2rVxszTSusAzzX9+4wtsyxuLKfoqiaA0bs484dVfRxUKF0ZHGZmz+pF
 IKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UH6DSWxpEa0sBtzIrN6w6cnzayujNCo8dIQNgHvbA10=;
 fh=KwcofSWoKCEhlAhYTAbcj2TMUaaA47iV2YtBLVVkp20=;
 b=aPsLygwKzh86KlW0ImjIs01sb/uBhe3NhkLtXAjxWPN0D+1ZTt1llKKbRs8JAppno0
 aN2bQsEp8tTbnCrCd5zdKxY3ujmsCzXH0PzHzdGraTVw+T1a/Jqq3LjqHnRAni7ONvdY
 +NhtaHnG4op/mncnvKHimA13/sH2O/i/zuSHP1qBptu8mmiUzM5aHofWdgWlJ8RlfE7A
 7rgJyAhCinTZ6fvWfZDagpXPNkFxeML7iOoLoQTnySPRCgwI2PnRvpd2uph+YYqwvk5O
 ZloTHBl2gvdMFJc7q4yhAjUGPlv3+sBAEiU2f+V6zlDRXaq4QR5rNIQ/9yB2uB2bbTe1
 dSzA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783446436; x=1784051236; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UH6DSWxpEa0sBtzIrN6w6cnzayujNCo8dIQNgHvbA10=;
 b=bYovmDJo+8UvCRd3O/uKDYqCMG0oRimJj9EvdP3K/iCWMPEFtLjYjam+rE491ntNHH
 l+FYUriWpZCwG/jN0PcNEH2DDyykgoalExmjhqvaYTnV0kZ8ACvsx96/yR19KNURNjKP
 3rKPX865UqfGH/sFNgfJXwAgtXKK7QTTZTX1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783446436; x=1784051236;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UH6DSWxpEa0sBtzIrN6w6cnzayujNCo8dIQNgHvbA10=;
 b=Sfb+vRf2gzaZvaQyL4vI+4gYu8iR1u9pqDCokgpjDro45AwnPKGKXVU42Emi9ujPmU
 T3461CXmnHJWHOdbSw69h/yHroToecDt6tQvVYq57P5IGVC/nXVTWGykekmO3sLDS0bl
 Cemigww3HtwXfefyAmX/tRhNcsfkWKeXNs1UgnAN5zpA3kMpbpmGjerOAe0CUo0Gh1Nx
 whPqidfOheHcJs9P45orP4DSf21HN4OWCd4i2tnCe9Yvb/S9QUFlEGETa1a5/Fclbmjd
 ptTRWEjuTws2eEeAvoBIKNPHJ6UuvxFsAk2Qd9qKJnAhu8R/J/Xz9ra9z+QS7wrQGAXo
 t+2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmWsecIw7wnksQzW2U8ghz/IysGiF6yYb9NF6yeX7d4tD4d1z1Ejr6m1MoOwuRTI/R4UE=@dpdk.org
X-Gm-Message-State: AOJu0YwzrBsqDA8SzWTt002z6qgH7XZaRWkzeV/J8Q9/PyaVPmixULWR
 A7bt1eY9ynxX2LXGPYvoxwPVqcMUAop6WmhNQ+EcGsqAoSgGgT9LEHA26dh6KXYzeXlBTOwPA/E
 5UzH2Tt2d29J/ePHtjLxr2RfA1zh4S0LvDociee0l7g==
X-Gm-Gg: AfdE7cmCRvC5LXb2UBx+F4qUGnL3gaxuQYR8JkyHjwU7bffIbGNjTDb3gRuslNk1r3S
 CbUxlXooJg0k+JR3UqoMysln25QaWE7LOBGKu+a+sZbWvqxBawkaFIbBkh+QBSTvBQXtzcQp0yL
 +iNfZWWy7OSFWY0oXqyABpxeYDyEtoXJcc7lJ+dlQM8ti2jWkL4izlYke/7BRd+1qMWXtOaWa16
 gb2u5EOsDAhGhxfTgTL4QCaOhUtKQ03bY3kGnRxQVOm/Z+km3kifrp11BFCjjt55tce4MFU3fju
 XNq0ambPRQ0VGoJb3DjKfuQMekcemXVa5nFS03k6
X-Received: by 2002:a05:6402:1ed6:b0:68d:92cf:52f4 with SMTP id
 4fb4d7f45d1cf-69a85647531mr3405489a12.5.1783446436495; Tue, 07 Jul 2026
 10:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260508141319.52648-1-abailey@iol.unh.edu>
 <20260511160013.78676-1-abailey@iol.unh.edu>
 <e135faa6-020a-42f1-a09f-e21e90dde010@arm.com>
 <CABJ3N2UPaeLyD7Mv1vtoQSvRJLK0MUfC0LHvvuz-kvjx1YKwcQ@mail.gmail.com>
 <CABJ3N2VPwsAoDyY4x=k=JQoU74UkdbQQRAy2LQgw_W9r-q8awQ@mail.gmail.com>
 <0b37dd2e-59ba-4f4a-84f9-3ae6e37f062e@arm.com>
In-Reply-To: <0b37dd2e-59ba-4f4a-84f9-3ae6e37f062e@arm.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 7 Jul 2026 13:47:05 -0400
X-Gm-Features: AVVi8CcSZmtvcidi2_BAtrZ80uxGM55dMv4QhAL_1pen7TDJr4UxojyPMNz9s0Y
Message-ID: <CABJ3N2W5VYcWR+wHkH+b7=JS6xb2qia-D5a5ZsNbjw_NzhR=eg@mail.gmail.com>
Subject: Re: [PATCH v4] dts: update test suite names to be clear and consistent
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, lylavoie@iol.unh.edu, 
 knimoji@iol.unh.edu, ahassick@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000052d251065608fb06"
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

--00000000000052d251065608fb06
Content-Type: text/plain; charset="UTF-8"

Thank you Luca for the suggestion,

This also does not seem to work. I believe it is because the .rst files are
being changed more than some threshold since they are only a couple lines
long to begin with. So git sees them as new files entirely rather than a
rename of the previous file.

--00000000000052d251065608fb06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Luca for the suggestion,<br><br>This also does n=
ot seem to work. I believe it is because the .rst files are being changed m=
ore than some threshold since they are only a couple lines long to begin wi=
th. So git sees them as new files entirely rather than a rename of the prev=
ious file.=C2=A0</div>

--00000000000052d251065608fb06--
