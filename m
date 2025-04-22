Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DDC369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 12:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB59540697;
	Tue, 22 Apr 2025 14:56:46 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mails.dpdk.org (Postfix) with ESMTP id 268F4402E6;
 Tue, 22 Apr 2025 14:56:44 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3015001f862so3907580a91.3; 
 Tue, 22 Apr 2025 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745326603; x=1745931403; darn=dpdk.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ejiRSsDX+Z9sPPh8/FP/akDnnBvhQy9At7SQiVkFC18=;
 b=cBfagLypRzhixH+8l1Uw5mbPedWAb3ebgdfu8425FkRmdRzFQRzuIGD6SstTVqNmfU
 HtT6TlNOTeRa6xmZo0mwyY/1fo5tT+gIZtOGnxHM+6+MZZcqsTqOpW6d/oQGg/7LCaOX
 3edFSaAZoJhv7Y2t5CXp4ZudnakHbes057/WFWJEIB5rgN6JkMkWtekh8/k8L5iYRavU
 JImsmuT8EmOBGBu7miDkfz9qKkjTxP5ADLpmi1O9cHj90Wkl6+0fvr58Fd33YgOpRkIR
 r1/nd2eLca5G1FOIecVmaTiHqrxid7akMHXRnoHl0yt8XBNmc+cm0PBJpTopv6WvUdmM
 I91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745326603; x=1745931403;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ejiRSsDX+Z9sPPh8/FP/akDnnBvhQy9At7SQiVkFC18=;
 b=NiKiUp8jIxAj+uBpsoEvtjbyBYoW9jsqTji24J31nYV8ivDNS6+LomQdBOKHGALQn+
 MXj4uim+U1n1a8DHBgy+lC1iBb4YfDCCg0a3aX0XUKcRdvaoFcuPkIIrw8fHSDaMGAu+
 aI+krX0oDd11JK6CpxKG+alPulbC6ShCuhFjGzJ1/NyahaDVHHlaS9nI7EyvXq5rbrHo
 hmWy26PiYgqtLDwPhGD8h0yV1kvLQZqSzGToksSRmhzmG2y4izlC4UdtW7aJOoPzeZ2t
 ESDCqTzgVvoO8vgsrDoXNyHA/KIftDo8LtRUdENEOkr3ke5FR8SOznir5G3YQ0wxOEG+
 kxzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQWDgpQ8OlM0pICib7Y+MARRc4PMk28wW7v8WWBAj0nm1xH+zXkzqVKp5xumJ0Ymk3V1Y=@dpdk.org
X-Gm-Message-State: AOJu0YzJNH+89s7b3jvmq8ky9Xy7zzM6o3WeF+Ll32rd5z4Zwt1LQTj5
 9nd/ePoZ1QytMQ3Ku/V/770tGJiwBhdMY8RwMnTTI3yu1WxyVAQJsmE/yGf2kzUPKCx8/ZrIONZ
 aRcWbJ/bnr1whWG3T5+E+76/0YD4EvykwJoV4cQ==
X-Gm-Gg: ASbGncvtQGtG0ioPY1aFseZBrIOVDYuL4WjIUsa34XTiw3pkXS+A3KU6gZ7EmWaH9B9
 xW7/+MC1j/QAXwcudo+aZ4N6x9S9Sas0+YgA+viPjTLGso5GJjOmLVMLAZyaWeiMdc6IHUmi7pp
 smHxl8UfSmIPVcWMV+1Y2oVp0=
X-Google-Smtp-Source: AGHT+IHMNuXg448PZLGxsy7OL49TfVYM5IZaPlYC1mN3swuwz/sAXIzFv7tvNoml2qR2lqVp/sXts4x+JS1uTEfsYBg=
X-Received: by 2002:a17:90b:37c5:b0:2fe:8902:9ecd with SMTP id
 98e67ed59e1d1-3087bb3e830mr18908557a91.1.1745326602623; Tue, 22 Apr 2025
 05:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABsV3rA5d=Hu3N5y3kCehV0+EpadqmLEEpcWyCdJO-0MhQZQRw@mail.gmail.com>
In-Reply-To: <CABsV3rA5d=Hu3N5y3kCehV0+EpadqmLEEpcWyCdJO-0MhQZQRw@mail.gmail.com>
From: spyroot <spyroot@gmail.com>
Date: Tue, 22 Apr 2025 16:56:31 +0400
X-Gm-Features: ATxdqUEgO3nx0KIhc2sHs_hP1-Gyz9Fk3kygZ06ZxTGOI6x1T5Qc4gDgWvCOOEM
Message-ID: <CABsV3rDXBirSem0KoMpzQ0G823_yVdTjiZM7UaWsxNrQcFJ8GA@mail.gmail.com>
Subject: Re: IAVF/ICEN Intel 810 (i.e SRIOV case) 16 queue and RSS dpdk-tested
 report single queue pps / stats
To: users@dpdk.org, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000002aa78e06335d84fa"
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

--0000000000002aa78e06335d84fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Observation.

Two instances of testpmd.  Only one report shows correct stats when you run
16 queues on RX with the default RSS config.
i.e rss-ip , rss-udp etc.  You only see the counter for a single queue.

How I know I took last report on first intestine test-pmd at the end of
run, take all bytes added. I know time I run compute pps
correlated to the PPS in the actual switch.

so either ICEN or IAVF doesn't report stats (only for queue 0)




On Fri, Apr 18, 2025 at 10:30=E2=80=AFPM spyroot <spyroot@gmail.com> wrote:

> Hi Folks,
>
>
> I am observing that DPDK test-pmd with IAVF PMD, ICEN PF driver,
>
> reporting statistics incorrectly when the RX side generates a UDP flow th=
at randomizes or increments IP/UDP header data (IP/port, etc).
>
> I tested all 23.x stable and all branches.
>
>
> -If I use *single* flow (on the TX side, all tuples are the same on the R=
X
>
> HASH() produce -> same result). no issue.
>
> So, on the RX side, I see all zero packet drops and the correct pps value=
 reported by test-pmd.
>
>
> - If I increase the number of flows ( IP/UDP, etc.), the PPS Counter and =
byte/pkt counter
>
> report only single queues. (i.e, it looks to me like it uses some default=
 queue 0
>
> or something and skips the rest 15 (in my case --rxq=3D16). (It could IAV=
F do that or ICEN report that). I'm not sure.
>
>
> For example, the counter I'm referring to test-pmd Rx-pps counter.
>
>
> Rx-pps: 4158531 Rx-bps: 2129167832
>
>
> I'm also observing PMD Failing fetch stats error msg.
>
>
> iavf_query_stats(): fail to execute command OP_GET_STATS
>
> iavf_dev_stats_get(): Get statistics failed
>
>
> My Question.
>
>
> If I have two instances of
>
> test-pmd --allowed X
>
> test-pmd --allowed Y
>
> Where X is VFs PCI ADDR X and Y  PCI ADDR Y from the  PF?
>
> I expect to see the total stats (pps/bytes, etc.) (combined value for all=
 16 queues for a port 0 )
>
> RX-PPS and bytes per port on both instances.
>
> Yes/No?
>
>
> Has anyone had a similar issue in the past?
>
>
> Thank you,
>
> MB
>
>

--0000000000002aa78e06335d84fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Observation.<div><br></div><div>Two instances of testpmd.=
=C2=A0 Only one report shows correct stats when you run 16 queues=C2=A0on R=
X with the default RSS config.</div><div>i.e rss-ip , rss-udp etc.=C2=A0 Yo=
u only see the counter for a=C2=A0single queue.=C2=A0<br><br>How I know I t=
ook last report on first intestine=C2=A0test-pmd at the end of run, take al=
l bytes added. I know time I run compute pps</div><div>correlated to the PP=
S in the=C2=A0actual switch.</div><div><br>so either ICEN or IAVF=C2=A0does=
n&#39;t report stats (only for queue 0)<br><br></div><div><br></div><div><b=
r></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Apr 18, 2025 at 10:30=E2=80=AFPM spyr=
oot &lt;<a href=3D"mailto:spyroot@gmail.com">spyroot@gmail.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><pre style=3D"font-size:10.5pt"><p style=3D"color:rgb(14,16,26);backgro=
und:transparent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background=
:transparent;margin-top:0pt;margin-bottom:0pt">Hi Folks,

</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin-to=
p:0pt;margin-bottom:0pt"></p><p style=3D"color:rgb(14,16,26);background:tra=
nsparent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transp=
arent;margin-top:0pt;margin-bottom:0pt">I am observing that DPDK test-pmd w=
ith IAVF PMD, ICEN PF driver, </span></p><p style=3D"color:rgb(14,16,26);ba=
ckground:transparent;margin-top:0pt;margin-bottom:0pt"><span style=3D"backg=
round:transparent;margin-top:0pt;margin-bottom:0pt">reporting statistics in=
correctly</span><span style=3D"background:transparent;margin-top:0pt;margin=
-bottom:0pt"> when the RX side generates a UDP flow that randomizes or incr=
ements IP/UDP header data (IP/port, etc). </span></p><p style=3D"color:rgb(=
14,16,26);background:transparent;margin-top:0pt;margin-bottom:0pt"><span st=
yle=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">I tested al=
l 23.x stable and all branches.</span></p><p style=3D"color:rgb(14,16,26);b=
ackground:transparent;margin-top:0pt;margin-bottom:0pt"></p><p style=3D"col=
or:rgb(14,16,26);background:transparent;margin-top:0pt;margin-bottom:0pt"><=
span style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">
-If I use </span><strong style=3D"background:transparent;margin-top:0pt;mar=
gin-bottom:0pt"><span style=3D"background:transparent;margin-top:0pt;margin=
-bottom:0pt">single</span></strong><span style=3D"background:transparent;ma=
rgin-top:0pt;margin-bottom:0pt"> flow (on the TX side, all tuples are the s=
ame on the RX </span></p><p style=3D"color:rgb(14,16,26);background:transpa=
rent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transparen=
t;margin-top:0pt;margin-bottom:0pt">HASH() produce -&gt; same result). no i=
ssue.</span></p><p style=3D"color:rgb(14,16,26);background:transparent;marg=
in-top:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-=
top:0pt;margin-bottom:0pt">So, on the RX side, I see all zero packet drops =
and the correct pps value reported by test-pmd.</span></p><p style=3D"color=
:rgb(14,16,26);background:transparent;margin-top:0pt;margin-bottom:0pt"></p=
><p style=3D"color:rgb(14,16,26);background:transparent;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"background:transparent;margin-top:0pt;margin-=
bottom:0pt">
- If I increase the number of flows ( IP/UDP, etc.), the PPS Counter and by=
te/pkt counter </span></p><p style=3D"color:rgb(14,16,26);background:transp=
arent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transpare=
nt;margin-top:0pt;margin-bottom:0pt">report only single queues. (</span><sp=
an style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">i.e</s=
pan><span style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt"=
>, it looks to me like it uses some default queue 0 </span></p><p style=3D"=
color:rgb(14,16,26);background:transparent;margin-top:0pt;margin-bottom:0pt=
"><span style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">o=
r something and skips the rest 15 (in my case --rxq=3D16). (It could IAVF d=
o that or ICEN report that). I&#39;m not sure.</span></p><p style=3D"color:=
rgb(14,16,26);background:transparent;margin-top:0pt;margin-bottom:0pt"></p>=
<p style=3D"color:rgb(14,16,26);background:transparent;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"background:transparent;margin-top:0pt;margin-b=
ottom:0pt">
For example, the counter I&#39;m referring=C2=A0to test-pmd Rx-pps counter.=
</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0=
pt;margin-bottom:0pt">
Rx-pps: 4158531 Rx-bps: 2129167832

</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin-to=
p:0pt;margin-bottom:0pt"></p><p style=3D"color:rgb(14,16,26);background:tra=
nsparent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transp=
arent;margin-top:0pt;margin-bottom:0pt">I&#39;m also observing PMD Failing =
fetch stats error msg.

</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0=
pt;margin-bottom:0pt">iavf_query_stats(): fail to execute command OP_GET_ST=
ATS</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-to=
p:0pt;margin-bottom:0pt">iavf_dev_stats_get(): Get statistics failed</span>=
</p><p style=3D"color:rgb(14,16,26);background:transparent;margin-top:0pt;m=
argin-bottom:0pt"></p><p style=3D"color:rgb(14,16,26);background:transparen=
t;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transparent;m=
argin-top:0pt;margin-bottom:0pt">
My Question.

</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0=
pt;margin-bottom:0pt">If I have two instances of </span></p><p style=3D"col=
or:rgb(14,16,26);background:transparent;margin-top:0pt;margin-bottom:0pt"><=
span style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">test=
-</span><span style=3D"background:transparent;margin-top:0pt;margin-bottom:=
0pt">pmd</span><span style=3D"background:transparent;margin-top:0pt;margin-=
bottom:0pt"> --allowed X</span></p><p style=3D"color:rgb(14,16,26);backgrou=
nd:transparent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:=
transparent;margin-top:0pt;margin-bottom:0pt">test-</span><span style=3D"ba=
ckground:transparent;margin-top:0pt;margin-bottom:0pt">pmd</span><span styl=
e=3D"background:transparent;margin-top:0pt;margin-bottom:0pt"> --allowed Y =
</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0=
pt;margin-bottom:0pt">Where X is VFs PCI ADDR X and Y  PCI ADDR Y from the<=
/span><strong style=3D"background:transparent;margin-top:0pt;margin-bottom:=
0pt"><span style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt=
"> </span></strong><span style=3D"background:transparent;margin-top:0pt;mar=
gin-bottom:0pt"> PF?</span></p><p style=3D"color:rgb(14,16,26);background:t=
ransparent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:tran=
sparent;margin-top:0pt;margin-bottom:0pt">I expect to see the total stats (=
pps/bytes, etc.) (combined value for all 16 queues for a port 0 ) </span></=
p><p style=3D"color:rgb(14,16,26);background:transparent;margin-top:0pt;mar=
gin-bottom:0pt"></p><p style=3D"color:rgb(14,16,26);background:transparent;=
margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transparent;mar=
gin-top:0pt;margin-bottom:0pt">RX-PPS and bytes per port on both instances.=
</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"background:transparent;margin-top:0=
pt;margin-bottom:0pt">Yes/No?</span></p><p style=3D"color:rgb(14,16,26);bac=
kground:transparent;margin-top:0pt;margin-bottom:0pt"></p><p style=3D"color=
:rgb(14,16,26);background:transparent;margin-top:0pt;margin-bottom:0pt"><sp=
an style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">
Has anyone had a similar issue in the past?

</span></p><p style=3D"color:rgb(14,16,26);background:transparent;margin-to=
p:0pt;margin-bottom:0pt"></p><p style=3D"color:rgb(14,16,26);background:tra=
nsparent;margin-top:0pt;margin-bottom:0pt"><span style=3D"background:transp=
arent;margin-top:0pt;margin-bottom:0pt">Thank you,</span></p><p style=3D"co=
lor:rgb(14,16,26);background:transparent;margin-top:0pt;margin-bottom:0pt">=
<span style=3D"background:transparent;margin-top:0pt;margin-bottom:0pt">MB<=
/span></p></pre><pre style=3D"font-size:10.5pt"><font color=3D"#c6c8d1"><sp=
an style=3D"font-family:Ayuthaya,monospace"></span></font></pre></div>
</blockquote></div>

--0000000000002aa78e06335d84fa--
