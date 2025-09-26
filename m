Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33261CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 00:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3315E4028F;
	Fri, 26 Sep 2025 02:04:53 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id CD72740273
 for <dev@dpdk.org>; Fri, 26 Sep 2025 02:04:51 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-799572d92b0so13130936d6.3
 for <dev@dpdk.org>; Thu, 25 Sep 2025 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758845091;
 x=1759449891; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WI47pfGO2+nMdO4AEspA28dGeKoon2RTQbbcuS8i06M=;
 b=xEppq4Lewh8eTy0k6P8JG3ADDjSaEa2PaHe+shK4jUcDAgTccsr/zyhj1evR2cgepF
 olS0uJkQtbjRNljFwYr2xnKm3V6Uye4OACAhfBeEmeAQW3b4v/rs2TOqjJ6macIxHcMg
 cCYRMvqqKFC7grQEBDi1CeIAqu1rIT3GlOzRKCEZkBmopouOCRBqwfYtAOhmkTfcGxEC
 0/h+Vn/Q8r78Lg4gM8lOhm2LNhQoAaOo3elJC8XW29hE1w/ksO3MAHNxe6bZaff/XiJ+
 yO7vzqNXXTuRy+UdMNgnk3Vg5VlWwTADp0hlx+YX8naNmZZdemUqVjqKzCxeAGIQoHKx
 DLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845091; x=1759449891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WI47pfGO2+nMdO4AEspA28dGeKoon2RTQbbcuS8i06M=;
 b=TlOWGE6FlMRb35ZHfl+p9TujB1+RpaG/39hpfQo+4Zl5qo8L1jIAv09sDC70Zf0bXu
 Zh/GZD7+PqOVgNTH1ynkYGv8vH7pMreGebRx/dnObIQcnHjdftGV0fwg+ySedopE4FRk
 OZUysbZU46MqRXDEdMJUIoJDGKnlXP0QtHWZEsdzMdMb2z1OygjxFuUzsWfFPrYYCxzV
 p1FIO+oY7yb/meXHn44ZUjjwTZk+WyDs/fnzhD/Aj6YOMDETmRNS0BR4EIiy3tx8SWba
 Ysd/y5wL5RatKcdIGs3S5QXUV1mCul0WeKHuTzvK5Zx2nlPEQpv3E56Pb/DAqpTTGnVE
 GauA==
X-Gm-Message-State: AOJu0YwKPh5G6iswtCiFRn1+OtKr6H+JCgj5z8zC0F0PAc8CwOZPbqM6
 9ADCMwsTEu//HhEVnmYTv38H/krCabc+Viy0d0G/aPw6xjCnMECNJYd4qyh6dINySJ8=
X-Gm-Gg: ASbGncvD5U2YGSAHi6LCe9OaQV6LSVHvkr6qICJZsmzq8EV8d0PJ+jfPsCPQwWgH9ji
 pRX9outbqSXRuZObFmMabwUzRmm9o3RKx3+G4Rk5yylxBu3TaPczh9lX1rogmSuDaMXwWdZ/5dM
 vSoXGDgSSOZSbmKLK9s3MaWCRldPfInIfxQPCngPPyvpm6tsOsP+S/mnYykwucCH79NikfEH+Tl
 d3ovDYpO4yyyCDbVYHSFPyQC9OxzOo2vROya88DnfrX0rWIPXSiMDSkUs7jD9bBwNTnRj5dgBB+
 305P0nYtOWQvU+YQagYmN3zQjf6xWh5hx/iRQaDDRk5z4Z8t+TEpDA6AHSoVVdnE6IB11fZLR8G
 FUCgChX1ZlKKJLibmm0duVW/WOsj3926EgGHD9J3Y7FalqABQ7qndo+Es0/N3nIo/8CTaNDQ6y7
 o=
X-Google-Smtp-Source: AGHT+IHeppYMSh4x/EU7n4q4FoS0Z+VBYJndWsypijc9tBuhQv508G4/VxX7Ce/nx+APCVU8cjCZ3A==
X-Received: by 2002:a05:6214:21c5:b0:78e:6248:ce70 with SMTP id
 6a1803df08f44-7fc2dfa7eadmr87516386d6.28.1758845091027; 
 Thu, 25 Sep 2025 17:04:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80167b8d8f6sm19102286d6.44.2025.09.25.17.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:04:50 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:04:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250925170447.2ae8d5bf@hermes.local>
In-Reply-To: <20250827223216.1337749-1-schneide@qti.qualcomm.com>
References: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
 <20250827223216.1337749-1-schneide@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 27 Aug 2025 16:32:15 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> =20
> +* pcapng: Changed the API for adding interfaces to include a link type a=
rgument.
> +  The link type was previously hardcoded to the ethernet link type in th=
e API.
> +  This argument is added to ``rte_pcapng_add_interface``.
> +  These functions are versioned to retain binary compatibility until the=
 next LTS release.

Since link connector is now merged, and that wording might overlap and
be confusing. Would be could to add reference to pcap-linktype.7 man
page.=20

Also, google search showed a related draft RFC.

 https://datatracker.ietf.org/doc/draft-ietf-opsawg-pcaplinktype/

In that RFC, the defines are LINKTYPE_XXX maybe that would be better
and break the dependency on libpcap for values. That means values will
come from IANA in future.

The enum (thanks to ChatGPT) for RFC draft would be:

typedef enum pcap_linktype {
    LINKTYPE_NULL               =3D 0,    /* BSD loopback encapsulation */ =
=20
    LINKTYPE_ETHERNET           =3D 1,    /* IEEE 802.3 Ethernet */
    LINKTYPE_EXP_ETHERNET       =3D 2,    /* Xerox experimental 3Mb Etherne=
t */
    LINKTYPE_AX25               =3D 3,    /* AX.25 layer 2 packets */
    LINKTYPE_PRONET             =3D 4,    /* Proteon PRONet Token Ring (res=
erved) */
    LINKTYPE_CHAOS              =3D 5,    /* MIT Chaosnet (reserved) */
    LINKTYPE_IEEE802_5          =3D 6,    /* IEEE 802.5 Token Ring */
    LINKTYPE_ARCNET_BSD         =3D 7,    /* ARCNET with BSD encapsulation =
*/
    LINKTYPE_SLIP               =3D 8,    /* SLIP, with a direction header =
*/
    LINKTYPE_PPP                =3D 9,    /* PPP */
    LINKTYPE_FDDI               =3D 10,   /* FDDI (ANSI INCITS 239-1994) */

    /* 11=E2=80=9349: not available for assignment (reserved) */

    LINKTYPE_PPP_HDLC           =3D 50,   /* PPP in HDLC-like framing */
    LINKTYPE_PPP_ETHER          =3D 51,   /* PPPoE session packets */

    /* 52=E2=80=9398: not available for assignment */

    LINKTYPE_SYMANTEC_FIREWALL  =3D 99,   /* Reserved for Symantec Enterpri=
se Firewall */
    LINKTYPE_ATM_RFC1483        =3D 100,  /* LLC/SNAP-encapsulated ATM */
    LINKTYPE_RAW                 =3D 101,  /* Raw IP (starts with IP header=
) */
    LINKTYPE_SLIP_BSDOS          =3D 102,  /* BSD/OS SLIP BPF header (reser=
ved) */
    LINKTYPE_PPP_BSDOS           =3D 103,  /* BSD/OS PPP BPF header (reserv=
ed) */
    LINKTYPE_C_HDLC              =3D 104,  /* Cisco PPP with HDLC framing */
    LINKTYPE_IEEE802_11          =3D 105,  /* IEEE 802.11 wireless LAN */
    LINKTYPE_ATM_CLIP             =3D 106,  /* Classical IP, no header befo=
re IP */
    LINKTYPE_FRELAY               =3D 107,  /* Frame Relay LAPF */
    LINKTYPE_LOOP                 =3D 108,  /* OpenBSD loopback encapsulati=
on */
    LINKTYPE_ENC                  =3D 109,  /* OpenBSD IPsec encapsulation =
(reserved) */
    LINKTYPE_LANE8023             =3D 110,  /* ATM LANE + 802.3 (reserved) =
*/
    LINKTYPE_HIPPI                 =3D 111,  /* NetBSD HIPPI (reserved) */
    LINKTYPE_HDLC                  =3D 112,  /* NetBSD HDLC framing (reserv=
ed) */
    LINKTYPE_LINUX_SLL              =3D 113,  /* Linux =E2=80=9Ccooked=E2=
=80=9D capture encapsulation */
    LINKTYPE_LTALK                   =3D 114,  /* Apple LocalTalk */
    LINKTYPE_ECONET                   =3D 115,  /* Acorn Econet (reserved) =
*/
    LINKTYPE_IPFILTER                  =3D 116,  /* OpenBSD ipfilter (reser=
ved) */
    LINKTYPE_PFLOG                       =3D 117,  /* PF logging (reserved)=
 */
    LINKTYPE_CISCO_IOS                     =3D 118,  /* Cisco internal use =
(reserved) */
    LINKTYPE_IEEE802_11_PRISM                =3D 119,  /* 802.11 + Prism mo=
nitor header */
    LINKTYPE_IEEE802_11_AIRONET                =3D 120,  /* 802.11 + Airone=
t metadata (reserved) */
    LINKTYPE_HHDLC                             =3D 121,  /* Siemens HiPath =
HDLC (reserved) */
    LINKTYPE_IP_OVER_FC                        =3D 122,  /* IP and ATM over=
 Fibre Channel */
    LINKTYPE_SUNATM                              =3D 123,  /* ATM from SunA=
TM */
    LINKTYPE_RIO                                    =3D 124,  /* RapidIO (r=
eserved) */
    LINKTYPE_PCI_EXP                                =3D 125,  /* PCI Expres=
s (reserved) */
    LINKTYPE_AURORA                                   =3D 126,  /* Xilinx A=
urora link (reserved) */
    LINKTYPE_IEEE802_11_RADIOTAP                       =3D 127,  /* 802.11 =
+ Radiotap header */
    LINKTYPE_TZSP                                        =3D 128,  /* Tazme=
n Sniffer Protocol (reserved) */
    LINKTYPE_ARCNET_LINUX                                  =3D 129,  /* ARC=
NET, Linux encapsulation */
    LINKTYPE_JUNIPER_MLPPP                                   =3D 130,
    LINKTYPE_JUNIPER_MLFR                                    =3D 131,
    LINKTYPE_JUNIPER_ES                                     =3D 132,
    LINKTYPE_JUNIPER_GGSN                                   =3D 133,
    LINKTYPE_JUNIPER_MFR                                    =3D 134,
    LINKTYPE_JUNIPER_ATM2                                   =3D 135,
    /* =E2=80=A6 and so on, up to LINKTYPE_DECT_NR =3D 301 in the initial s=
et =E2=80=A6 */
    LINKTYPE_DOCSIS                                        =3D 143,  /* DOC=
SIS MAC frames */
    LINKTYPE_LINUX_IRDA                                    =3D 144,
    LINKTYPE_IBM_SP                                          =3D 145,
    LINKTYPE_IBM_SN                                           =3D 146,
    LINKTYPE_RESERVED_01                                      =3D 147,  /* =
deprecated private use */
    LINKTYPE_RESERVED_02                                      =3D 148,
    LINKTYPE_RESERVED_03                                      =3D 149,
    /* ... through LINKTYPE_RESERVED_15 (i.e. up to 162) ... */
    LINKTYPE_ZWAVE_TAP                                       =3D 297,
    LINKTYPE_SILABS_DEBUG_CHANNEL                            =3D 298,
    LINKTYPE_FIRA_UCI                                        =3D 299,
    LINKTYPE_MDB                                              =3D 300,
    LINKTYPE_DECT_NR                                          =3D 301,

    /* Experimental / Private-Use range begins at 65001..65535 */
} LinkType;







