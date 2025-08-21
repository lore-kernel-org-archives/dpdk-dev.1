Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74909CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 11:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BD59402ED;
	Thu, 21 Aug 2025 13:16:21 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 597B340292
 for <dev@dpdk.org>; Thu, 21 Aug 2025 13:16:20 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7e8706764d2so109785585a.2
 for <dev@dpdk.org>; Thu, 21 Aug 2025 04:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755774980;
 x=1756379780; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F7Tg6ClH8fBEHtxPvQSqB7FTQdy+SEAoLs5i+iel9+c=;
 b=oI8mUIPawox6OxdJMhanmxXxVMYOES2p8sNpVOU/WwvQ9Xb5ILpy2ODXw7D1MgCp7b
 9K+7kcIq7m1h0CUpdQgiDs9EYU70S+mTUtt34gB2+eclNxXdMoM7N0IQnFAKCjGyqT1u
 aW3K3w9ubkCyYtXTC+VHBGVHMRrtE7/y0gxz6Ze21a1V5ZDYYN/DzIslJCmkgr7L0eFC
 oev+OTdwfWdsfeTJjcWc9IOZT6oKCqWGip/3sbXn3ezQiqSjBYIsRuKtYOYTJ+V46fm1
 0hwasXnBU2Pk4pcErhCJ/XCC9j/vGH+ICHI3bHVy0vPSOYaBBJesJ9myJgqzSKDyCWr0
 qvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755774980; x=1756379780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F7Tg6ClH8fBEHtxPvQSqB7FTQdy+SEAoLs5i+iel9+c=;
 b=j8g0Oil5E+Uw349g1ZmCUKO1+cAk64U4RLOJIijVicinfYhHmLhOsngbIeKWfcnjDj
 GW69kkGxTghnxbF7mnjJMC4VvaiCQMc+Pu4uMRe85JL+OpjhZOtBYp4qSf7NiSZW7Ogc
 OlTIYcot6hOvVHy3Vy6OzU8RyG1ccAlcwPdfJX2rEcSLzhLbJor+UnEuKQCDBlT7HFmI
 myWp/mYS0kT8tn+CPxmpHMl0z4A/SLLgI6V710TaIpmWs7b6MDhvLC0X/Pb9QBwbO6k7
 QnKCv3CB4vn9quWh5pXgiGqTtmsucvf87Ifs5qhRvagA2LxZcmWWuQZ0yMW1HDMwj18O
 GMjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu19illkObW/xPmo5Y1JcZAmvqtmQ8PZ1wi/SL8EeXchsbPnoJSEBSzmf1tx108YKwxP8=@dpdk.org
X-Gm-Message-State: AOJu0YwdV9M2a3vzIqhy3eZhBEvghgbwkmzL347P8+0PW4UGyI3DvnIb
 ua+2tiwsPGTTIi/MLYZqH07IkSjj1wfOPci9TEKH93XYLgNQK10m4Mb5yr5CECSJyct9bX0Kk+I
 rHQyFmiyuffh1E5xV8GtGxVLDDpSY2/3Bq6bI5HFoiA==
X-Gm-Gg: ASbGnctlXhoCcx7RHHCrWHSEf79YM0rlC6o2HCMoWCpNlLoL0nLwoKsRvr8V1kznveN
 JKqP7yPkcvsvbrARpocElpNV7YuE/UBNcJYaYssaEyY/H53atg1X53exjhgOlLtcgPIkwhqIy+w
 Xef1bKrgjQzGEerStXwaxw+4HevSyoO4OGXrfZ+fB2S7NC34xobxxdfj6FjWPJTbqXdKHQ4mgxE
 3D8WADm
X-Google-Smtp-Source: AGHT+IFTNxNedRw2v8FClwO45M165K9fjR7tQfQqcjV8n6wkPtjjiTL7m3R1jfCNH3bZ0hkEToKKKMQLCLOBxTX3vpc=
X-Received: by 2002:a05:620a:19aa:b0:7e0:6012:f18f with SMTP id
 af79cd13be357-7ea08e5dd87mr178215285a.49.1755774979412; Thu, 21 Aug 2025
 04:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
 <20250811062149.2489151-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250811151520.bonpjpefwuzuap65@ds-vm-debian.local>
In-Reply-To: <20250811151520.bonpjpefwuzuap65@ds-vm-debian.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Thu, 21 Aug 2025 16:16:08 +0500
X-Gm-Features: Ac12FXxodXYFSoKKVWkX6uPqSbBWRXwdVzf4g7A51Y2Scynn6wO6_fQIaBQfi8I
Message-ID: <CA++2-x5oR5qPvYK=JSWdqAAu6yFhbE+eFK38xBCCOQVKv_MZzA@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: ivan.malov@arknetworks.am, viacheslavo@nvidia.com, bingz@nvidia.com, 
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com, dev@dpdk.org, 
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f42ceb063cde37fb"
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

--000000000000f42ceb063cde37fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dariusz,
I have tested the following example and it is working fine.
Can we add this example to documentation
(either in https://doc.dpdk.org/guides/testpmd_app_ug/testpmd_funcs.html or
mlx5 or somewhere else) ?

On Mon, Aug 11, 2025 at 8:17=E2=80=AFPM Dariusz Sosnowski <dsosnowski@nvidi=
a.com>
wrote:

>
> [1]: Full conntrack example, testpmd commands:
>
> # Initial conntrack action configuration: original direction, state
> SYN_RECV, liberal mode and enabled
> set conntrack com peer 0 is_orig 1 enable 1 live 0 sack 0 cack 0 last_dir
> 0 liberal 1 state 0 max_ack_win 0 r_lim 5 last_win 510 last_seq 2000
> last_ack 101 last_end 101 last_index 0x2
> set conntrack orig scale 0xf fin 0 acked 1 unack_data 0 sent_end 101
> reply_end 65535 max_win 0 max_ack 0
> set conntrack rply scale 0xf fin 0 acked 1 unack_data 0 sent_end 2001
> reply_end 65535 max_win 0 max_ack 101
> flow indirect_action 0 create ingress action conntrack / end
>
> # Create a rule for original direction
> flow create 0 group 3 ingress pattern eth / ipv4 src is 1.2.3.4 dst is
> 5.6.7.8 / tcp src is 40000 dst is 50000 / end actions indirect 0 / jump
> group 5 / end
>
> # Update conntrack action - now rule will created for reply direction
> set conntrack com peer 0 is_orig 0 enable 1 live 0 sack 0 cack 0 last_dir
> 0 liberal 1 state 0 max_ack_win 0 r_lim 5 last_win 510 last_seq 2000
> last_ack 101 last_end 101 last_index 0x2
> flow indirect_action 0 update 0 action conntrack_update dir / end
>
> # Create a rule for reply direction
> flow create 0 group 3 ingress pattern eth / ipv4 src is 5.6.7.8 dst is
> 1.2.3.4 / tcp src is 50000 dst is 40000 / end actions indirect 0 / jump
> group 5 / end
>
> # Create group 0 rule for TCP traffic
> flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump group 3
> / end
>
> # Match valid packets, mark and send to queue 0
> flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 /
> end actions mark id 0x111 / queue index 0 / end
> # Match valid packets which change connection state
> flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 3 /
> end actions mark id 0x333 / queue index 0 / end
>
> set verbose 1
> set fwd rxonly
> start
>
> Example packets to send after all flow rules are created:
>
> # ACK in handshake: transition SYN_RECV->ESTABLISHED; logged as "FDIR
> matched ID=3D0x333"
> pkt =3D (Ether() / IP(src=3D'1.2.3.4', dst=3D'5.6.7.8') / TCP(sport=3D400=
00,
> dport=3D50000, flags=3D'A', seq=3D101, ack=3D2001))
>
> # some data from original direction; logged as "FDIR matched ID=3D0x111"
> pkt =3D (Ether() / IP(src=3D'1.2.3.4', dst=3D'5.6.7.8') / TCP(sport=3D400=
00,
> dport=3D50000, flags=3D'A', seq=3D101, ack=3D2001) / Raw(load=3Db'a' * 10=
0))
>
> # ack from reply direction; logged as "FDIR matched ID=3D0x111"
> pkt =3D (Ether() / IP(src=3D'5.6.7.8', dst=3D'1.2.3.4') / TCP(sport=3D500=
00,
> dport=3D40000, flags=3D'A', seq=3D2001, ack=3D201))
>
> # fin from original direction; logged as "FDIR matched ID=3D0x333"
> pkt =3D (Ether() / IP(src=3D'1.2.3.4', dst=3D'5.6.7.8') / TCP(sport=3D400=
00,
> dport=3D50000, flags=3D'F', seq=3D201, ack=3D2001))
>
> # ack from reply direction; logged as "FDIR matched ID=3D0x333"
> pkt =3D (Ether() / IP(src=3D'5.6.7.8', dst=3D'1.2.3.4') / TCP(sport=3D500=
00,
> dport=3D40000, flags=3D'A', seq=3D2001, ack=3D202))
>
> # fin from reply direction; logged as "FDIR matched ID=3D0x333"
> pkt =3D (Ether() / IP(src=3D'5.6.7.8', dst=3D'1.2.3.4') / TCP(sport=3D500=
00,
> dport=3D40000, flags=3D'F', seq=3D2001, ack=3D202))
>
> # ack from original direction; logged as "FDIR matched ID=3D0x333"
> pkt =3D (Ether() / IP(src=3D'1.2.3.4', dst=3D'5.6.7.8') / TCP(sport=3D400=
00,
> dport=3D50000, flags=3D'A', seq=3D201, ack=3D2002))
>

Best Regards,
Khadem

--000000000000f42ceb063cde37fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Dariusz,<br></div><div>I have tested the following=
 example and it is working fine.=C2=A0=C2=A0</div><div>Can we add this exam=
ple to documentation=C2=A0</div><div>(either in <a href=3D"https://doc.dpdk=
.org/guides/testpmd_app_ug/testpmd_funcs.html">https://doc.dpdk.org/guides/=
testpmd_app_ug/testpmd_funcs.html</a> or mlx5 or somewhere else) ?=C2=A0=C2=
=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Aug 11, 2025 at 8:17=E2=80=AFPM Dariusz So=
snowski &lt;<a href=3D"mailto:dsosnowski@nvidia.com">dsosnowski@nvidia.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
br>
[1]: Full conntrack example, testpmd commands:<br>
<br>
# Initial conntrack action configuration: original direction, state SYN_REC=
V, liberal mode and enabled<br>
set conntrack com peer 0 is_orig 1 enable 1 live 0 sack 0 cack 0 last_dir 0=
 liberal 1 state 0 max_ack_win 0 r_lim 5 last_win 510 last_seq 2000 last_ac=
k 101 last_end 101 last_index 0x2<br>
set conntrack orig scale 0xf fin 0 acked 1 unack_data 0 sent_end 101 reply_=
end 65535 max_win 0 max_ack 0<br>
set conntrack rply scale 0xf fin 0 acked 1 unack_data 0 sent_end 2001 reply=
_end 65535 max_win 0 max_ack 101<br>
flow indirect_action 0 create ingress action conntrack / end<br>
<br>
# Create a rule for original direction<br>
flow create 0 group 3 ingress pattern eth / ipv4 src is 1.2.3.4 dst is 5.6.=
7.8 / tcp src is 40000 dst is 50000 / end actions indirect 0 / jump group 5=
 / end<br>
<br>
# Update conntrack action - now rule will created for reply direction<br>
set conntrack com peer 0 is_orig 0 enable 1 live 0 sack 0 cack 0 last_dir 0=
 liberal 1 state 0 max_ack_win 0 r_lim 5 last_win 510 last_seq 2000 last_ac=
k 101 last_end 101 last_index 0x2<br>
flow indirect_action 0 update 0 action conntrack_update dir / end<br>
<br>
# Create a rule for reply direction<br>
flow create 0 group 3 ingress pattern eth / ipv4 src is 5.6.7.8 dst is 1.2.=
3.4 / tcp src is 50000 dst is 40000 / end actions indirect 0 / jump group 5=
 / end<br>
<br>
# Create group 0 rule for TCP traffic<br>
flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump group 3 /=
 end<br>
<br>
# Match valid packets, mark and send to queue 0<br>
flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / e=
nd actions mark id 0x111 / queue index 0 / end<br>
# Match valid packets which change connection state<br>
flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 3 / e=
nd actions mark id 0x333 / queue index 0 / end<br>
<br>
set verbose 1<br>
set fwd rxonly<br>
start<br>
<br>
Example packets to send after all flow rules are created:<br>
<br>
# ACK in handshake: transition SYN_RECV-&gt;ESTABLISHED; logged as &quot;FD=
IR matched ID=3D0x333&quot;<br>
pkt =3D (Ether() / IP(src=3D&#39;1.2.3.4&#39;, dst=3D&#39;5.6.7.8&#39;) / T=
CP(sport=3D40000, dport=3D50000, flags=3D&#39;A&#39;, seq=3D101, ack=3D2001=
))<br>
<br>
# some data from original direction; logged as &quot;FDIR matched ID=3D0x11=
1&quot;<br>
pkt =3D (Ether() / IP(src=3D&#39;1.2.3.4&#39;, dst=3D&#39;5.6.7.8&#39;) / T=
CP(sport=3D40000, dport=3D50000, flags=3D&#39;A&#39;, seq=3D101, ack=3D2001=
) / Raw(load=3Db&#39;a&#39; * 100))<br>
<br>
# ack from reply direction; logged as &quot;FDIR matched ID=3D0x111&quot;<b=
r>
pkt =3D (Ether() / IP(src=3D&#39;5.6.7.8&#39;, dst=3D&#39;1.2.3.4&#39;) / T=
CP(sport=3D50000, dport=3D40000, flags=3D&#39;A&#39;, seq=3D2001, ack=3D201=
))<br>
<br>
# fin from original direction; logged as &quot;FDIR matched ID=3D0x333&quot=
;<br>
pkt =3D (Ether() / IP(src=3D&#39;1.2.3.4&#39;, dst=3D&#39;5.6.7.8&#39;) / T=
CP(sport=3D40000, dport=3D50000, flags=3D&#39;F&#39;, seq=3D201, ack=3D2001=
))<br>
<br>
# ack from reply direction; logged as &quot;FDIR matched ID=3D0x333&quot;<b=
r>
pkt =3D (Ether() / IP(src=3D&#39;5.6.7.8&#39;, dst=3D&#39;1.2.3.4&#39;) / T=
CP(sport=3D50000, dport=3D40000, flags=3D&#39;A&#39;, seq=3D2001, ack=3D202=
))<br>
<br>
# fin from reply direction; logged as &quot;FDIR matched ID=3D0x333&quot;<b=
r>
pkt =3D (Ether() / IP(src=3D&#39;5.6.7.8&#39;, dst=3D&#39;1.2.3.4&#39;) / T=
CP(sport=3D50000, dport=3D40000, flags=3D&#39;F&#39;, seq=3D2001, ack=3D202=
))<br>
<br>
# ack from original direction; logged as &quot;FDIR matched ID=3D0x333&quot=
;<br>
pkt =3D (Ether() / IP(src=3D&#39;1.2.3.4&#39;, dst=3D&#39;5.6.7.8&#39;) / T=
CP(sport=3D40000, dport=3D50000, flags=3D&#39;A&#39;, seq=3D201, ack=3D2002=
))<br>
</blockquote></div><div><br clear=3D"all"></div><div>Best Regards,=C2=A0</d=
iv><div>Khadem=C2=A0</div></div>

--000000000000f42ceb063cde37fb--
