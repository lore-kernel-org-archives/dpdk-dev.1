Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF5C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 12:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAC3341101;
	Mon,  5 May 2025 14:51:50 +0200 (CEST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by mails.dpdk.org (Postfix) with ESMTP id 07C484021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 13:25:20 +0200 (CEST)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-5240a432462so4809850e0c.1
 for <dev@dpdk.org>; Mon, 28 Apr 2025 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745839519; x=1746444319; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=21wTbIADrIVQ+iMCczsUx+mf7967eWxkp8lrTFEeKiM=;
 b=Ma9XaJ7mroU7Y39pzLFoF2oh37iTgC6xXpMdID+4A5rVDxuiBTJGfK8SvrWqaIxlkb
 NSiUiySy0rQeW4nTWeJx/dxOfe0h9bLH/eC0ofkqxx8yUBPA49pugSoHTEIP+1vhBf8N
 gN9uuB8jbkdylsbUdkcMflFc8afC264fCsoaF3J54lg/ebYojAvzesvsI14xXaci8CdZ
 hFjQRBERS3gM/AQuhq4kDuqwrREK31ob6CUqVodOqQNhhSKUHLSzoTU0SKXbNleV4Ilj
 XCJGSFiChG54Ti7CaplEWMwjkNwON8/pKZfciAkoyZs0k61hGo2EmQ89b9cUz5zZFRU3
 PfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745839519; x=1746444319;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=21wTbIADrIVQ+iMCczsUx+mf7967eWxkp8lrTFEeKiM=;
 b=Hm2F4NdrJqPuC5dgc9D8NPl9BLi0hnO+T3fSNPEUvh2o5K2Rm4JsuIoGKVebP5ID1l
 ogmc50bJ2/GtzKD1Ioi+KGbPW/IJL3tTo4tat1BBoDTAHGu5/DCcIYHfka4+YPfH+oCs
 KK41uKIeMUsRj0rrdt0q/VIux4ohiUu9jFv//h8C/eugyr5IscrdwdJeFzglJx4HwNti
 OQdG8shimra7IQdAPCKWSXGVT2EfK9SQ2yWkBxpTKXaH7jqtHxPoPDI0CnBNFP3vqz/Q
 RanBlcfNAl33drPFIvchhaTXJ5xVSTHtnCaF7G59XX7BS/ZxiXe9nfKZO0iwbR8GAMAa
 2//Q==
X-Gm-Message-State: AOJu0YyuWODNTaT0NjKTJ7rpvBBerjxrIo1Xfu6gCm3eCrpD9KXYJcXU
 Nl5e9N0+NA100A/UdgnDjA7wbWfWdzjcJYcrvxuEI2bPKos+FJUlrZk2o6T+0doHhGDQmDA2mZK
 YnWNPY/lxMY1r1JOP7/u6AfRhLdJcKT3w
X-Gm-Gg: ASbGncuMnMbX8jVbRl+Bcv/HuylWlatgkwkD0wKsg0njoFkCaRqEz+FsOZ+WpDzIFUZ
 JnI8KolxP8HOHGVQqmQm2yJCzZ5YOqE+HaponmN68HTCnCjx4IbG3bH12h4Lq0ZPRHsVoSbGULf
 6mjIPImfthVvrHjVlnYkIQK0Y=
X-Google-Smtp-Source: AGHT+IEOVIHg0W4O2cGtkL3uAKgP/3D+W0PbavauUxL6bsIk94Hi/FU1xdjlqtpUQToW4bps72Ur1nq5dJo3khzhiNk=
X-Received: by 2002:ac5:cc67:0:b0:524:2fe0:3898 with SMTP id
 71dfb90a1353d-52a79eba883mr9719471e0c.5.1745839518923; Mon, 28 Apr 2025
 04:25:18 -0700 (PDT)
MIME-Version: 1.0
From: farooq basha <farooq.juturu@gmail.com>
Date: Mon, 28 Apr 2025 16:55:07 +0530
X-Gm-Features: ATxdqUGVMKWCqmgfUmnWR3JA1MCeK7OpySnI2jmR9TQapbkewnbA9SuRcWXjCKA
Message-ID: <CA+xuiv2jL934JR_QyLC1M5A+5dGPzw5L0=4RoS98eRjueA+9-g@mail.gmail.com>
Subject: [dpdk-dev] Regarding HQOS with run-to-completion Model
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005c46680633d4f076"
X-Mailman-Approved-At: Mon, 05 May 2025 14:51:04 +0200
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

--0000000000005c46680633d4f076
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello DevTeam,

    I am planning to use DPDK HQOS for Traffic shaping with a
run-to-completion Model. While I was reading the dpdk-qos document, I came
across the following statement.

"*Running enqueue and dequeue operations for the same output port from
different cores is likely to cause significant impact on scheduler=E2=80=99=
s
performance and it is therefore not recommended"*

 Let's take an  example, Port1  & Port2 have 4 Rx queues and each Queue
mapped to a different CPU. Traffic coming on port1  gets forwarded to port2
. With the above limitation application needs to take a lock before doing
rte_sched_port_enqueue & dequeue operation. Performance is limited to only
1 CPU even though Traffic is coming on 4 Different CPUs.

Correct me if my understanding is Wrong?

Thanks
Basha

--0000000000005c46680633d4f076
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello DevTeam,=C2=A0<div><br></div><div>=
=C2=A0 =C2=A0 I am planning to use DPDK HQOS for Traffic shaping with a run=
-to-completion Model. While I was reading the dpdk-qos document, I came acr=
oss the following statement.=C2=A0</div><div><span style=3D"background-colo=
r:rgb(252,252,252);color:rgb(64,64,64);font-family:Lato,proxima-nova,&quot;=
Helvetica Neue&quot;,Arial,sans-serif;font-size:16px"><br></span></div><div=
><span style=3D"background-color:rgb(252,252,252);color:rgb(64,64,64);font-=
family:Lato,proxima-nova,&quot;Helvetica Neue&quot;,Arial,sans-serif;font-s=
ize:16px">&quot;</span><b style=3D"color:rgb(64,64,64);font-family:Lato,pro=
xima-nova,&quot;Helvetica Neue&quot;,Arial,sans-serif;font-size:16px">Runni=
ng enqueue and dequeue operations for the same output port from different c=
ores is likely to cause significant impact on scheduler=E2=80=99s performan=
ce and it is therefore not recommended&quot;</b></div><div><span style=3D"c=
olor:rgb(64,64,64);font-family:Lato,proxima-nova,&quot;Helvetica Neue&quot;=
,Arial,sans-serif;font-size:16px;background-color:rgb(252,252,252)"><b><br>=
</b></span></div><div><font color=3D"#404040" face=3D"Lato, proxima-nova, H=
elvetica Neue, Arial, sans-serif"><span style=3D"background-color:rgb(252,2=
52,252)">=C2=A0Let&#39;s take an=C2=A0 example, Port1=C2=A0 &amp; Port2 hav=
e 4 Rx queues and each Queue mapped to a different CPU. Traffic coming on p=
ort1=C2=A0 gets forwarded to port2 . With the above limitation application =
needs to take a lock before doing rte_sched_port_enqueue &amp; dequeue oper=
ation. Performance is limited to only 1 CPU even though Traffic is coming o=
n 4 Different CPUs.=C2=A0</span></font></div><div><span style=3D"background=
-color:rgb(252,252,252);color:rgb(64,64,64);font-family:Lato,proxima-nova,&=
quot;Helvetica Neue&quot;,Arial,sans-serif"><br></span></div><div><span sty=
le=3D"background-color:rgb(252,252,252);color:rgb(64,64,64);font-family:Lat=
o,proxima-nova,&quot;Helvetica Neue&quot;,Arial,sans-serif">Correct me if m=
y understanding is Wrong?=C2=A0</span></div><div><span style=3D"background-=
color:rgb(252,252,252);color:rgb(64,64,64);font-family:Lato,proxima-nova,&q=
uot;Helvetica Neue&quot;,Arial,sans-serif"><br></span></div><div><span styl=
e=3D"background-color:rgb(252,252,252);color:rgb(64,64,64);font-family:Lato=
,proxima-nova,&quot;Helvetica Neue&quot;,Arial,sans-serif">Thanks</span></d=
iv><div><span style=3D"background-color:rgb(252,252,252);color:rgb(64,64,64=
);font-family:Lato,proxima-nova,&quot;Helvetica Neue&quot;,Arial,sans-serif=
">Basha=C2=A0</span></div><div><br></div><div><br></div><div><span style=3D=
"color:rgb(64,64,64);font-family:Lato,proxima-nova,&quot;Helvetica Neue&quo=
t;,Arial,sans-serif;font-size:16px;background-color:rgb(252,252,252)"><b><b=
r></b></span></div></div></div>

--0000000000005c46680633d4f076--
