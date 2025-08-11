Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B35CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 16:27:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 912F640E21;
	Mon, 11 Aug 2025 18:27:53 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 9AF164068E
 for <dev@dpdk.org>; Mon, 11 Aug 2025 18:27:52 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-707389a2fe3so41863816d6.2
 for <dev@dpdk.org>; Mon, 11 Aug 2025 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754929672;
 x=1755534472; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0/EEOgrthQ15rFTIotNBE13yRrY7lL27hrc0uyZToGk=;
 b=Zk2hWcpGLYSRJnX5opnIixxMG7EnflbrSzUOBE/kTlSATBm+oyH+Z4hgT5LlsNXUUe
 fewy43wdYHlPdBrW/PjyZl9H1y8/AjTz4XWC7X01LJYklKfYu4Ft8IWUFH+NXS4ZMGrx
 UlPcVJb+L7b51Z+lJ4gb0FMDZcYkpyB9IAqZqr4fSfYoOP8/+Ct2oOt3IAOb3xTOHXQm
 3iBz/VmrOe38XWjxmc+L3P488lWxlg9s4XF/6Q8RSBNF+onTTW9RriizlCcvfk2UvIk2
 YfQeAoJEI/tT4iTvgKydie5oKp7pfS0bygf0YjSZZJSo5F/x3pLAAzobFUOkiTZkD30+
 PA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929672; x=1755534472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/EEOgrthQ15rFTIotNBE13yRrY7lL27hrc0uyZToGk=;
 b=jOghUUi96wBoc3FUGx+354xujlydxopMg+iVc7vDU8jnOcCQkbkWUpDKY5jx4P+LIB
 UysRaQAGcF/eqt0luInUy62ljWcwct+PVQEXBU0PNEoS27yLh1g/MobqWJlwdFNWoESH
 jMytGqjm9rkYaeT1ljlvCBCMkpD1Eei9HEJJdQUObj+y3XBoc5GvjC1NN1qxk6HX0s+N
 nB2hnfRDPrXiqDd4e5BEtd3B8iykRWd2TlzEZHT78FwSOt0tdveBY4rHyPMoLriUIpRR
 NjYcs9ms5vOM9mHQFusFEWUMSlgbv2iht2heWqLbM3nYcyKn75WiSEAoT3VPIyjA3O95
 NfiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzX6yudgJp/IjjUIBpmTfrgUwJXObvYXo2pPO4a8u+syfF0K6NUxxl88fRpxZeHwhDduo=@dpdk.org
X-Gm-Message-State: AOJu0Yw2CRZgSaZytvZygCKo/SRN1qDYwy5iulVCKm7PLi+dP1XmjF/5
 BRXUe2yYTICagz11jNrrlz61CnGmxASsTYbZW327Tb73pWQxrKGpL4Thwaj50i2WOYXv1J9gMrj
 JxHPalOURzbWSsNBXACJvfiNgTktAo8KOuerrR0OVxg==
X-Gm-Gg: ASbGncukyIN9MEJgh8jwOOzutZEVFNdIjsDOVm7dDSU7qJYO4xKc2wl+6iRtH2F4Fqu
 yPC21ooYc+SAaSl2WPmq1vVMS5lvXa4AkVXpkBkYH+JwmQ3Bib6RSo9zxmPwN59ukAhNWjr3Y0S
 ldpGpRpR27UBW7tVYDno16Wc9F0LnIqI/dofStiOsuBK1cEoNtyutVboS+/KXYlxpsC01qt8eg9
 mnl7C0V
X-Google-Smtp-Source: AGHT+IGhRefjMa8kDAmKzym3tpXC/odhFTjZqlSFxJJIaZwJnuSs/0WJimtihPGgHkrlyzZgWm2Wg82QGIIoyv77pmg=
X-Received: by 2002:a05:6214:5003:b0:707:50ee:7f24 with SMTP id
 6a1803df08f44-709d5e150e9mr8018626d6.39.1754929671783; Mon, 11 Aug 2025
 09:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
 <20250811062149.2489151-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250811151520.bonpjpefwuzuap65@ds-vm-debian.local>
In-Reply-To: <20250811151520.bonpjpefwuzuap65@ds-vm-debian.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 21:27:06 +0500
X-Gm-Features: Ac12FXzRXPUHplf7hga-OTvW0WshOxAYeMrQcAALk8HNvETwHmzF-P5nxXb6aj0
Message-ID: <CA++2-x5voCjMDXcO_jJw6vrmvtDzfPaAArABeAT9TGcVzXtoZA@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: ivan.malov@arknetworks.am, viacheslavo@nvidia.com, bingz@nvidia.com, 
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com, dev@dpdk.org, 
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b15a30063c19671c"
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

--000000000000b15a30063c19671c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for providing these details. Sure, I will go through it (will
performed the experiment) and come back to you.
I totally agree that the documentation about connection tracking should be
improved.


On Mon, Aug 11, 2025 at 8:17=E2=80=AFPM Dariusz Sosnowski <dsosnowski@nvidi=
a.com>
wrote:

>
> > Are these the only testpmd commands you execute?
>
> No, as I mentioned earlier, I have provided only relevant information. I
had added something similar commands as yours,
the following was missing from my configurations.

set conntrack com peer 1 is_orig 1 enable 1 live 1 sack 1 cack 0 last_dir 0
liberal 1 state 0 max_ack_win 7
r_lim 3 last_win 510 last_seq 65535 last_ack 65537 last_end 65545
last_index 0x8

set conntrack orig scale 7 fin 1 acked 1 unack_data 0 sent_end 65545
reply_end 65535 max_win 28960 max_ack 2632987379
set conntrack rply scale 7 fin 0 acked 1 unack_data 0 sent_end 65545
reply_end 65535 max_win 65280 max_ack 2532480967

. > 3 conntrack item deals with RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap

  > In your example, "conntrack is 1" specification sets flags to 1.
   > This means, "match packets with RTE_FLOW_CONNTRACK_PKT_STATE_VALID"
   >and not "connection in RTE_FLOW_CONNTRACK_STATE_ESTABLISHED".

   > The same goes for "conntrack is 2". It specifies match on
   > RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED, not on
   >R TE_FLOW_CONNTRACK_STATE_FIN_WAIT or any other state.
>
  > Because it is a bitmap, conntrack item can specify a combination of
   >P KT_STATE flags. For example, "conntrack is 3" would mean matching
   >a packet with RTE_FLOW_CONNTRACK_PKT_STATE_VALID and
   >RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED flags set.

Can this RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap be represented with a
specific valid range ?
for example, we can say, 'conntrack is' valid for 1 to 8, or any other
range. As, currently user can specify
any value e.g., 1000 and it allows it.

Thanks again!
Best regards,
Khadem

--000000000000b15a30063c19671c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thank you for providing these details. Sure, I will g=
o through it (will performed the experiment) and come back to you.=C2=A0</d=
iv><div>I totally agree that the documentation about connection tracking sh=
ould be improved.=C2=A0 =C2=A0=C2=A0</div><div><br></div><div><br></div><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Aug 11, 2025 at 8:17=E2=80=AFPM Dariusz Sosnowski &lt;<a h=
ref=3D"mailto:dsosnowski@nvidia.com">dsosnowski@nvidia.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>&gt; Are thes=
e the only testpmd commands you execute?<br><br></blockquote><div>No, as I =
mentioned earlier, I have provided only relevant information. I had added s=
omething similar commands as yours,=C2=A0</div><div>the following was missi=
ng from my configurations.=C2=A0</div><div><br></div><div>set conntrack com=
 peer 1 is_orig 1 enable 1 live 1 sack 1 cack 0 last_dir 0 liberal 1 state =
0 max_ack_win 7 <br>r_lim 3 last_win 510 last_seq 65535 last_ack 65537 last=
_end 65545 last_index 0x8<br><br>set conntrack orig scale 7 fin 1 acked 1 u=
nack_data 0 sent_end 65545 reply_end 65535 max_win 28960 max_ack 2632987379=
<br>set conntrack rply scale 7 fin 0 acked 1 unack_data 0 sent_end 65545 re=
ply_end 65535 max_win 65280 max_ack 2532480967<br>=C2=A0 =C2=A0<br>. &gt; 3=
 conntrack item deals with RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap<br>
<br>=C2=A0 &gt; In your example, &quot;conntrack is 1&quot; specification s=
ets flags to 1.<br>=C2=A0 =C2=A0&gt; This means, &quot;match packets with R=
TE_FLOW_CONNTRACK_PKT_STATE_VALID&quot;<br>=C2=A0 =C2=A0&gt;and not &quot;c=
onnection in RTE_FLOW_CONNTRACK_STATE_ESTABLISHED&quot;.<br>
<br>=C2=A0 =C2=A0&gt; The same goes for &quot;conntrack is 2&quot;. It spec=
ifies match on<br>=C2=A0 =C2=A0&gt; RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED, n=
ot on<br>=C2=A0 =C2=A0&gt;R TE_FLOW_CONNTRACK_STATE_FIN_WAIT or any other s=
tate.<br>&gt;<br>=C2=A0 &gt;=C2=A0Because it is a bitmap, conntrack item ca=
n specify a combination of<br>=C2=A0 =C2=A0&gt;P KT_STATE flags. For exampl=
e, &quot;conntrack is 3&quot; would mean matching<br>=C2=A0 =C2=A0&gt;a pac=
ket with RTE_FLOW_CONNTRACK_PKT_STATE_VALID and<br>=C2=A0 =C2=A0&gt;RTE_FLO=
W_CONNTRACK_PKT_STATE_CHANGED flags set.</div><div><br></div><div>Can this=
=C2=A0RTE_FLOW_CONNTRACK_PKT_STATE_* bitmap be represented with a specific =
valid range ?=C2=A0<br></div><div>for example, we can say, &#39;conntrack i=
s&#39; valid for 1 to 8, or any other range. As, currently user can specify=
=C2=A0</div><div>any value e.g., 1000 and it allows it.=C2=A0=C2=A0<br></di=
v><div><br></div><div>Thanks again!</div><div>Best regards,=C2=A0</div><div=
>Khadem=C2=A0</div></div></div>

--000000000000b15a30063c19671c--
