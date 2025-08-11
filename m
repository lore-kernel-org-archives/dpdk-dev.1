Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8456BC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 06:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5946402E6;
	Mon, 11 Aug 2025 08:22:23 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 514E54025D
 for <dev@dpdk.org>; Mon, 11 Aug 2025 08:22:22 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b427094abdeso3733413a12.3
 for <dev@dpdk.org>; Sun, 10 Aug 2025 23:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754893341;
 x=1755498141; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EldddhkGCuwKbXNDxm5G/D8Wp6/vmHDgNEXXDsZUjBs=;
 b=cB6Q16i+/zTr0Bdj6wmUHqlhAOZwBUdLawq8fjgmw7AP65IzB1nLvh2KzZgUx9hrhC
 47SP7wFx9hLGEDe2s0n2PDuHiSGph10rDaGSf/wLqUtWpUQQGRxUpSNv1VJs7RIvzcdX
 3oCLLUGkZdHOQmryQQiyBQ3qUDYUkOm+s0yLsld+MFD8pG4IExojI7bl/j5QymmbkBmx
 XcGvBjPbiWwowbFY+9hIFqDjbyzmkWY1DXTJme3EBLJzt/xS0BbVXb3kyZEOkU8Pym/i
 spAMPWLM5/DDgQRzQf8bYpLKYPoFnfswMCNmw+o5XkfxuNvur/bexuBBn9zuJyd6TgRn
 QpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754893341; x=1755498141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EldddhkGCuwKbXNDxm5G/D8Wp6/vmHDgNEXXDsZUjBs=;
 b=EJzfnIxgGj6l4E5z+TAOhqET6uvfQ/mLfkNCHl4rDRNRRgmbhGoehZPVol0MA6mBre
 20WWJmo+KYgOUychr8WG6o1iTDpWbYuhDA950u9YmD4+fKWMH+w1Irs9KzKeY05i1N3r
 hLDkVKq5c480j3ZfwmyWuEwbx332+KkQaS3u+jSs6wt2E7Y3hDNuk3JlGXpUA3NxFDnW
 ew2qW6ndqVsGA6v6PoL/JxK1l4iIn5GqhL/LZsqFlyaR/WzMnCM5QMxCTKq+On2WTDhN
 D/9CMdfI0y5KSrsN4hCocpW+X/GtF/xRysrIJxgphvDsRekkHISpIIM1bqps3XXKGwAb
 YPcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfcXApa7ln6QCxTlL8CnXUiglbDDwuJdQDnL0zmRTgsUCn446OfWgG7ufcQoagwNa9TIA=@dpdk.org
X-Gm-Message-State: AOJu0YwpmSzJXTUU7txsl3L4hMfbd4oYA9OnGcJY2eoXTWmt5iK52cmH
 R4p80Zg1D0M5miCo1YxgGx8funi8Y4AjjUCL2cegZYNyNm25tz4d2bx83SH6b5Ha5bw=
X-Gm-Gg: ASbGncs8jEHOwPwQbLVR9VdFMG6RdI74AvbkVJ+eKPRvX5Y8u9seMQQ3CQbSv06f4Ve
 casrSWDuvTl3VVdxc7sPnYXJWQ2goGEckOUGe/yV9i8o8Fnhknha4NdwbUE2jGYUF7PSfzAWWnz
 GovgXxOa7MLBrD1hEGMOvrUTnoO5l3Dhc1l5+9VdOrdLFR57KFg8F9wKRC+134ypSfFXwtUdjl4
 k4DVZM9hboJPs+zwhjLjl5FttnFCvhegVfQvRuO19exy9MhJq5LeIn9kqXZcgyEcUtFrbFo6/mk
 vuaLyV7zZ6ARxYu3d8DAosj9jgJXcfmJrYvl2Cam0cziTnFkdbZB8fdtB0eSQlmOeFUlfu3WD0U
 DtRy0p/CKwKwAwHweVv96SAaooVQQFFcCx7uTDj6WNkDRvTWT
X-Google-Smtp-Source: AGHT+IER0M9FsR4+w+KopdZ1/eqUYnWOJgbLBLdGHpEed5La5t/aiDcsZxue5iYdnsRdeiFBWbYODQ==
X-Received: by 2002:a17:903:41c9:b0:240:11ba:3842 with SMTP id
 d9443c01a7336-242c21df705mr177468725ad.35.1754893340922; 
 Sun, 10 Aug 2025 23:22:20 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef7557sm262163515ad.19.2025.08.10.23.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 23:22:20 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dsosnowski@nvidia.com,
	ivan.malov@arknetworks.am
Cc: viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
Date: Mon, 11 Aug 2025 02:21:49 -0400
Message-ID: <20250811062149.2489151-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
References: <20250808074738.2nqgorlqzzyf2jid@ds-vm-debian.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Dariusz Sosnowski, 

According to documentation, conntrack item matches a conntrack 
state after conntrack action. Your statement is also correct 
"match valid TCP packets which change TCP connection state", 
it means in this case also we are matching TCP connection state. 

Please check CONNTRACK item in Generic flow API (rte_flow)
16.2.6.47. Item: CONNTRACK

Matches a conntrack state after conntrack action.

    flags: conntrack packet state flags.
    Default mask matches all state bits.

https://doc.dpdk.org/guides-24.07/prog_guide/rte_flow.html

E.g. I have performed the following experiemtns on connect-x6-Dx for clarification
(provding only the relevent information).

conntract state can be verified for liberal mode.
In liberal mode, the Seq/ACK/Win check will be ignored (forget about act/seq)
and only the state change will be tracked.

Test 1 : Starting state machine from State 0  

flow indirect_action 0 create ingress action conntrack / end
flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump group 3 / end
flow create 0 group 3 ingress pattern eth / ipv4 / tcp / end actions indirect 0 / jump group 5 / end
flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / end actions queue index 1 / end
flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 2 / end actions queue index 2 / end
set fwd rxonly 
start 
set verbose 3 

The following packets will be forwared to queue 1, it means the state machine is now in established state (state 1). 
sendp(Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x10), iface="",count=1)  
sendp(Ether(dst="bb:cc:dd:ee:ff:22",src="aa:bb:cc:dd:ee:ff")/IP(src="150.1.10.10")/TCP(ack=265,seq=265,dport=5555,flags=0x18), iface="",count=1)

FIN packet Terminate the connection; the following packets will be forwarded to queue 2:
pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x01)
pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x10)
pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x01)
pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x10)

This will be again forwarded it to queue 1: 
pkt=Ether()/IP()/TCP(ack=265,seq=265,dport=5555,flags=0x10)

So, according to my understanding(from rte_flow and various experiments), 
conntrack item ('conntract is') matches the state of the connection tracking 
state machine in hardware 
and forward it to the relevent queue. 

In any case, I think only a range of values for "conntract is" to be allowed. 

Best Regards, 
Khadem
