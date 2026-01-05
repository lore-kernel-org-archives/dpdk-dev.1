Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88068C79F88
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 12:15:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DB644026F;
	Mon,  5 Jan 2026 13:15:19 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id B441340267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 13:15:16 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b7eff205947so1949228466b.1
 for <dev@dpdk.org>; Mon, 05 Jan 2026 04:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767615316; x=1768220116; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R/kR1lFpJaa7NDedxxzO6UH6dwejYZud0RNvWrYjWwQ=;
 b=lw9k7c4nc8mK7Xy2AlLPBB76EputA9NKZCVEza9RevgBhMMgVzE9mwiJXcyd1ky7K2
 vS/gBNV3BhHXv2aamxpgloL7e4TCyZJeBoietKPmVmBWHfsW5dFL9qus2RuTFWSh7rO2
 p7Z8s6xpT5144rVld1QM6ShrQbqq1JKn+llas9MVK8Rq3am+lEDHcZ5ZKAoYDDPvtsyE
 XSsfbNHZzWvX9fh8AZabbtBMdYnKPKP/VcbI+Bg81p51jV2E7/Rxw1AvFjynAO/pd2j0
 idPvm7nfHJNCBHELDGH9JsNQJXMlf6RnFA9/gVWHEpoaw8SFu1cdk0z31G7NoalWdcac
 RmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767615316; x=1768220116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/kR1lFpJaa7NDedxxzO6UH6dwejYZud0RNvWrYjWwQ=;
 b=pXkkOoxGkX9/4c4SiQvZ8x76u9DOKcCGHrx0cYfQUVAo54CmZa0ecrg+2wWvdALORl
 5GT+6g7QZSJcdRpdFlN5tORbfKwHRCBpPomWckww/th+idBlory2fuRNSrmf+yFJnORM
 pubjpYlyQcQ/nE0WV9z5VekjsFu/gbIH+rqbeURfitkGLbjpBGP6fYAXQpGyG5v/n7qy
 XvhjSAHVvSgtJbCzCiP2jaWNArxGi7BHbuWS7/2wF5ruyc0zwA1ucJQ0v81YRFNDm6Eh
 1AgD5wuUT6AWSVwCQ0JqDh0EgAWGv/Lqe0xOjCN/ZEyrJANRyAeL0F8WovBdFXsdui6o
 4wsQ==
X-Gm-Message-State: AOJu0YzvptBQrGLZIfX8NUMb7D1lbw9IPck5/iTN4PO1LpbQuteS1rp3
 7XHkPeDcyo6ogBUAGuxwsuagBaypbAUTuhh50qiOaObVRnQVCk9Rln2ni9vdmd2kKkW/xWq9xpH
 az2MfT6SsTc4mdOfPTYmsVIbbypd5aJIwDS6J
X-Gm-Gg: AY/fxX4TEtZXcT5Y2Cu1dghmX+5TLMtUF+cnM4IMPcWZIZh6JpybUgs50kdlvfbaOAO
 m346R4Zx+6AVnRmjq0tXGA1JHLS/UDeWHoV5zD9ppUSR8DYenWVB8dDl8dqPJ5tz08iHJ4TP6UN
 rjBrdTmdt7Gjux+d83UFl9GPxKbtcbx/M4FIT8IkMzfRuEzyDtUyeZUyDn3uZea/7FXqVhT3z2h
 6Ov1+W/V0uvibL53iCTifsP+rVaT8xpt4S0xtdjUoB7vwtjs45k0OpGV6v/2CBAc7pkohI=
X-Google-Smtp-Source: AGHT+IFpChs6u2IpAsBG/hXu0AfjUejCGUVIQgNTiMRwWFSFYepL0eLdMGFx1/ggLoTknsQP5OU2svxAWHdDqxMzR8Y=
X-Received: by 2002:a17:907:7e86:b0:b76:8074:344b with SMTP id
 a640c23a62f3a-b8036ebdd9emr4891663066b.8.1767615315918; Mon, 05 Jan 2026
 04:15:15 -0800 (PST)
MIME-Version: 1.0
References: <tencent_69DB16741AF61177F2E130402BCC8683ED06@qq.com>
 <CANxNyavqQNqaF9Mx+QEBY5PVMzk45Yd7D703P5tCkXUfnU_RLw@mail.gmail.com>
In-Reply-To: <CANxNyavqQNqaF9Mx+QEBY5PVMzk45Yd7D703P5tCkXUfnU_RLw@mail.gmail.com>
From: kumaraparameshwaran rathinavel <kumaraparamesh92@gmail.com>
Date: Mon, 5 Jan 2026 17:45:04 +0530
X-Gm-Features: AQt7F2pLtEtRKKeAZJw9Bmj5uPQqwo99mg2I02MdT_QaQDUnN6IO-4VVLOm37IA
Message-ID: <CANxNyavogrpWUvE1M65xWxEsBjTYj-s_EHdw-VFNAJ7BBUWgqw@mail.gmail.com>
Subject: Re: RFC - GRO Flowlookup Optimisation
To: =?UTF-8?B?6IOh5ZiJ55Gc?= <hujiayu.hu@foxmail.com>, 
 Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000000141b30647a303ca"
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

--0000000000000141b30647a303ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiayu, Thomas,

I had recently posted a patch to do flow operations based on hash for the
timer mode GRO. Stephen had started reviewing it. The implementation would
not work for the burst mode GRO where we try to coalesce the packets
received in single burst. To make this work for the burst mode, it=E2=80=99=
s not
straightforward as the tables are just declared in the stack and the new
hash based implementation cannot fit in to this design easily.

To address this and keep it simple, can we have just one mode where we try
do GRO as long as the burst never returns 0 or we receive a packet with
flags like FIN/PSH. I think this is similar to kernel GRO as well. We
should have a timer / logic to periodically to scavenge to flush the flows
which is the current timer based implementation.

Please let me know your thoughts on this.

Thanks.
Kumara


On Wed, 22 Nov 2023 at 9:06=E2=80=AFPM, kumaraparameshwaran rathinavel <
kumaraparamesh92@gmail.com> wrote:

>
>
> On Wed, Nov 22, 2023 at 8:44=E2=80=AFPM =E8=83=A1=E5=98=89=E7=91=9C <huji=
ayu.hu@foxmail.com> wrote:
>
>> Hi Kumara,
>>
>> It is a good idea. You can send the code and I will help to review.
>>
>>> Thanks Jiyau. Will try to get out a PR in few days.
>>>
>>
>> Thanks,
>> Jiayu
>> ------------------------------
>> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84iPhone
>>
>>
>> ------------------ Original ------------------
>> *From:* kumaraparameshwaran rathinavel <kumaraparamesh92@gmail.com>
>> *Date:* Wed,Nov 22,2023 2:01 PM
>> *To:* dev <dev@dpdk.org>, hujiayu.hu <hujiayu.hu@foxmail.com>
>> *Subject:* Re: RFC - GRO Flowlookup Optimisation
>>
>> Hi Folks,
>>
>> The current GRO code uses an unoptimised version of flow lookup where
>> each flow in the table is iterated over during the flow matching process=
.
>> For a rte_gro_reassemble_burst in lightweight mode this would not cause
>> much of an impact. But with rte_gro_reassemble which is done with a time=
out
>> interval, this causes higher CPU utilisation during throughput tests. Th=
e
>> proposal here is to use a Hash based flowtable which could make use of t=
he
>> rte_hash table implementation in DPDK. There could be a hash table for e=
ach
>> of the GRO types. The lookup function and the key could be different for
>> each one of the types. If there is a consensus that this could have a
>> better performance impact I would work on an initial patch set. Please l=
et
>> me know your thoughts.
>>
>> Thanks,
>> Kumara.
>>
>

--0000000000000141b30647a303ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Jiayu, Thomas,</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">I had recently posted a patch to do flow operations based on ha=
sh for the timer mode GRO. Stephen had started reviewing it. The implementa=
tion would not work for the burst mode GRO where we try to coalesce the pac=
kets received in single burst. To make this work for the burst mode, it=E2=
=80=99s not straightforward as the tables are just declared in the stack an=
d the new hash based implementation cannot fit in to this design easily.=C2=
=A0=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">To address thi=
s and keep it simple, can we=C2=A0have just one mode where we try do GRO as=
 long as the burst never returns 0 or we receive a packet with flags like F=
IN/PSH. I think this is similar to kernel GRO as well. We should have a tim=
er / logic to periodically to scavenge to flush the flows which is the curr=
ent timer based implementation.=C2=A0</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Please let me know your thoughts on this.=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Thanks.</div><div dir=3D"auto">Kumara=
=C2=A0</div><div dir=3D"auto"><br></div><div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 22 Nov=
 2023 at 9:06=E2=80=AFPM, kumaraparameshwaran rathinavel &lt;<a href=3D"mai=
lto:kumaraparamesh92@gmail.com">kumaraparamesh92@gmail.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left=
-color:rgb(204,204,204)"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov =
22, 2023 at 8:44=E2=80=AFPM =E8=83=A1=E5=98=89=E7=91=9C &lt;<a href=3D"mail=
to:hujiayu.hu@foxmail.com" target=3D"_blank">hujiayu.hu@foxmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;bo=
rder-left-color:rgb(204,204,204)"><div style=3D"min-height:22px;margin-bott=
om:8px">Hi Kumara,</div><div style=3D"min-height:22px;margin-bottom:8px"><b=
r></div><div style=3D"min-height:22px;margin-bottom:8px">It is a good idea.=
 You can send the code and I will help to review.<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">Thank=
s Jiyau. Will try to get out a PR in few days. <br></blockquote></div></blo=
ckquote></div></div><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,=
204)"><div style=3D"min-height:22px;margin-bottom:8px"><br></div><div style=
=3D"min-height:22px;margin-bottom:8px">Thanks,</div><div style=3D"min-heigh=
t:22px;margin-bottom:8px">Jiayu</div><div id=3D"m_97921188080866262m_446969=
966628184478QQMailSignature" aria-hidden=3D"true"><hr style=3D"margin:0px 0=
px 10px;border-width:0px 0px 1px;border-style:none none solid;height:0px;li=
ne-height:0;font-size:0px;padding:20px 0px 0px;width:50px;border-color:curr=
entcolor currentcolor rgb(230,232,235)">=E5=8F=91=E8=87=AA=E6=88=91=E7=9A=
=84iPhone</div><div id=3D"m_97921188080866262m_446969966628184478original-c=
ontent"><br><br><div><div style=3D"font-size:70%;padding:2px 0px">---------=
--------- Original ------------------</div><div style=3D"font-size:70%;back=
ground:0% 0% repeat rgb(240,240,240);padding:8px;border-radius:4px;color:rg=
b(33,33,33)"><div><b>From:</b> kumaraparameshwaran rathinavel &lt;<a href=
=3D"mailto:kumaraparamesh92@gmail.com" target=3D"_blank">kumaraparamesh92@g=
mail.com</a>&gt;</div><div><b>Date:</b> Wed,Nov 22,2023 2:01 PM</div><div><=
b>To:</b> dev &lt;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpd=
k.org</a>&gt;, <a href=3D"http://hujiayu.hu" target=3D"_blank">hujiayu.hu</=
a> &lt;<a href=3D"mailto:hujiayu.hu@foxmail.com" target=3D"_blank">hujiayu.=
hu@foxmail.com</a>&gt;</div><div><b>Subject:</b> Re: RFC - GRO Flowlookup O=
ptimisation</div></div></div><br><div dir=3D"ltr"><div>Hi Folks,<br></div><=
div><br></div><div>The current GRO code uses an unoptimised version of flow=
 lookup where each flow in the table is iterated over during the flow match=
ing process. For a rte_gro_reassemble_burst in lightweight mode this would =
not cause much of an impact. But with rte_gro_reassemble which is done with=
 a timeout interval, this causes higher CPU utilisation during throughput t=
ests. The proposal here is to use a Hash based flowtable which could make u=
se of the=C2=A0 rte_hash table implementation in DPDK. There could be a has=
h table for each of the GRO types. The lookup function and the key could be=
 different for each one of the types. If there is a consensus that this cou=
ld have a better performance impact I would work on an initial patch set. P=
lease let me know your thoughts. <br></div><div><br></div><div>Thanks,</div=
><div>Kumara. <br></div></div>

</div></blockquote></div></div>
</blockquote></div></div>

--0000000000000141b30647a303ca--
