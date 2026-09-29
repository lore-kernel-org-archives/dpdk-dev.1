Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE43CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A325C40E0A;
	Tue, 29 Sep 2026 16:59:16 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id E1DEA40679
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:59:15 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so2716152b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790693955; cv=none;
 d=google.com; s=arc-20260327;
 b=WQl0OOrcT6JClBm4BBLIP1UupoFaOEyuS6dLyu6QOWO/9AvG1ntLmGUHPKVf1JMuqd
 zLU+FT6lhqdRTDeZ//2hh8EPMKAu9onFGJS9kpdEcumRlL1QkLTk53mfKpBmVIv2PEUA
 nl5DPg6Bk3zuG21epOweh2hfpwZzvdrN6+v/KYI1mSF2vUQJEtRKfoIbzshhw9VR1Cqk
 RW72cwOtsnjl+UiTCxl+5FZc7nuuB2IifpxUwz/pb0xRePcbMYq3BGZ/hYmaH+YstsWr
 3Cs20So9wlhJB08aAdnKnlaIiflOvD6T0BAOiapDuUqJBMf5KA1FMZ+hD38Xej9dGWXg
 Sr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZXzDMMjNe5sPgOK7CbEVDzfi3E/hQatsaYGl9GhW8cQ=;
 fh=QXLS1AGB8qRq12/a2sv+mRqjJF7jivrfIekDHZiiEwM=;
 b=Q89w/ZLezyMRivk6Yj0LCTH88WYzEi9gHwZ9zLI45PpBHFMK/YOieZdunziWd5h/fo
 kyaenHqxiXeOh3BDOJqKVUgScmLU2sl/q7EFgGaT2zqfnnad+hfTNiP4q7Q2OdEIeMW1
 qsnycIvK+q0M7wpTpdu3N6eNup8kJobbj86wNSoGFUuvHgeiVh7vON5J2PB7BJO5oht7
 C4leE0k8dibVuTpB2brq+BMljMpmzERPLw4+oJJV77AAQQ4Xx7ea0cwbawqxMQeztoB+
 20opWAqTUUb5A5xp6z2Y1TUnOsaaKSZLYMzcdSgDGOVZRjsAL2h/aK6FD47hv5vXbxeE
 4d0g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790693955; x=1791298755; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZXzDMMjNe5sPgOK7CbEVDzfi3E/hQatsaYGl9GhW8cQ=;
 b=RgzSRPDwgbj9PLSxq4Wnjve5sLMcC9QHuEzyeg8pA6FmDs3I6qvheZ+Wt3al5WLKWj
 Q94Km+sFoze+CL6HR6J+x1QgBYW94vdlASgID+it3/P8udeeOmmf//1qvI/Nc7QikvJu
 guvAw0ukhOyzXWprgQ3h08RSkhfRgv/CcPnf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790693955; x=1791298755;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZXzDMMjNe5sPgOK7CbEVDzfi3E/hQatsaYGl9GhW8cQ=;
 b=wbJyLiNwcQ+lao/61zaUCTtvN+xVl+0QSle1WBlUTjV7F/TC6vvk3ki8vLh9eRN9H0
 XoZqoV6NAlF7JES/lukEpCNW0y0SjaRMpvSbMbWeHmcBic76WpMnON8O6/LpZn32oXWe
 PdEpVBq/OX90AsFLd+wOLsD6noVEWLhbsxH9ynt+eXJVI5zBl7a1SwSHPqfHeB6UftTn
 KdjUZXa/2z9+VDq0mVCKuDF8bXstQMQPWDNn9ID+jiFfdLt77VRhpYq7hIq1XlTZH0FR
 S3TlWcXzy2KuzVOwxN8NG7X6axy7Nu2guPn+qhUQbB2LNg0p8JMvigz8vd/cMCvXLXvJ
 cPGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxh5AAqwjfoGEESStwSssTDroFEj21rljtD3L6KIkPrCTBrUi7bp2hmW+3e4+mIU+wZrQ8=@dpdk.org
X-Gm-Message-State: AFuF++lQhrJPfpeb5Nn5zHT6VrD41ej++5tPHderncY9E2Xa2DC1U6gv
 Zb0DG2csXppJzV6eQZ3EguB6FZ1U7DOmHIRfjN/e4euCJXVKX2DOSGw4T8YK9IdDCM33HzEkRKF
 2LTSeDT0KAIPCCAkzFAzjY7tTObwFv6Z3uSWRNUFHyQ==
X-Gm-Gg: AYBFou1N/zNZc0Ub2Q4B12Ky23GMq7PLq3Bjz/q9PMq6ky/xH4LlBdfsTY8hRIS4RIS
 XNNp6CHBwmEgTvABtOtFxMzUzCwUHzA3nLyo/AVJ1Qh3MMmUMWOXWHAT5XQdpToZ3lkIWmSnLRF
 UqIyA6uHBMyvXJD2vreZLuCsNl0HgdQZnIoTT9xKYacx0rz29VTyKiW3Kin17WmoRYGFsKQnQbg
 72LoYsrNpnpa/BOK2NEv0btBi50gvKegzNsykW+HIUYbhS2qVCq3JKOeHOF4aWLdY/KzqkoyGDk
 DSIEhcotDy3ZjZ2+kryzAnynkgPfGZtCpAoUBQ0Ibf1OlivHU0PfbUAvyefVzZCp6n2j9Q==
X-Received: by 2002:a05:6a00:90a6:b0:87c:d00a:f351 with SMTP id
 d2e1a72fcca58-87e9c0699b4mr13090671b3a.47.1790693954936; Tue, 29 Sep 2026
 07:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260901185957.453730-1-knimoji@iol.unh.edu>
 <20260908144707.862960-1-knimoji@iol.unh.edu>
In-Reply-To: <20260908144707.862960-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 29 Sep 2026 10:59:01 -0400
X-Gm-Features: AclHuK8Ndcw2I3YVvjhmpmOXt9CFefkeFBsSPYq13tPcwuM-kNuxn7H5UVLr7sA
Message-ID: <CABJ3N2XNxqT-o5TFBBXcAcDYaGCo2He5q4e=904o4A1oFYobeQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add pvp multi paths vhost performance testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000015f114065ca06d52"
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

--00000000000015f114065ca06d52
Content-Type: text/plain; charset="UTF-8"

>
>
> +    def set_up_suite(self):
> +        """Assign test parameters."""
> +        self.test_parameters = self.config.test_parameters
> +        self.delta_tolerance = self.config.delta_tolerance
> +
> +    def set_up_test_case(self):
> +        """Delete stale vhost-user Unix domain socket files."""
> +        self._ctx.sut_node.main_session.send_command("rm -rf
> /tmp/vhost-net*", privileged=True)
>

I missed this part in my first review, This portion needs to live in the
framework. There is no guarantee that the cleanup will be the same across
all systems and
implementation should live in linux session rather than the test suite.

--00000000000015f114065ca06d52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
+=C2=A0 =C2=A0 def set_up_suite(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Assign test parameters.&quot=
;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_parameters =3D self.config.test_para=
meters<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.delta_tolerance =3D self.config.delta_tol=
erance<br>
+<br>
+=C2=A0 =C2=A0 def set_up_test_case(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Delete stale vhost-user Unix=
 domain socket files.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ctx.sut_node.main_session.send_command(&=
quot;rm -rf /tmp/vhost-net*&quot;, privileged=3DTrue)<br></blockquote><div>=
=C2=A0</div><div>I missed this part in my first review, This portion needs =
to live in the framework. There is no guarantee that the cleanup will be th=
e same across all systems and <br>implementation should live in linux sessi=
on rather than the test suite.<br><br></div></div></div>

--00000000000015f114065ca06d52--
