Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A5C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 14:41:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4F74402D2;
	Tue, 25 Feb 2025 15:41:39 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 785ED402AE
 for <dev@dpdk.org>; Tue, 25 Feb 2025 15:41:38 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-22114b800f7so113761985ad.2
 for <dev@dpdk.org>; Tue, 25 Feb 2025 06:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740494497;
 x=1741099297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWPvygBFs6O5QDZIZ/MVdDVxz0Ebf/ECzSp5eEbPLto=;
 b=R1tn3eUsDnB19Zf+w6itvq/jNbdCc8Oze/D84hYFy5vE1AIFmnCV8RJNBuBpSG+IK3
 CkDFRJURYJ1/EqKaMHWdJaqNoDZQkMwyQG4dGfT41uZ5dJW4khmsTs98AQLBjBzvL8ZW
 IerL0vBQCt31Api74yRiUVADTFeAzfH5t57HxaDZbq+W9YgI8I/toPBK1+3NsAkV3oU3
 RfVA8hYI6VgWMTgy5ipIaoOcGqDPcjtv3pojCDm37YdFhPke53qqMCh9vrsr6avh9M2O
 yFswhBGM1p6S1/1ZBhLgY3NZSOHXB9cafydGCk4etxAveY13qMetTFkg6g2InP531tJT
 yS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740494497; x=1741099297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWPvygBFs6O5QDZIZ/MVdDVxz0Ebf/ECzSp5eEbPLto=;
 b=SH9EpntpFpT7vK4r1/XxG7QnUVgtDNLuwKbVZvA8nhIVwCl3wlBJwS4oVLrBZ02cjP
 ypnXakA/TJgHRADIh1//ZXMv4Wv3j9udtQa/7KpVaxWeJ3/TF6Z3QwC26W41tZXDWRzE
 zRRHv3OpvEKBgBI736+K42m3iFvGJf+r1JeZJv3hxExohd9a1YWNPfaukw79QsT/7k/O
 OhPNLnIht5+DoxZO+WN6pi6YJurDlksd8yyPICkP4jd2tkLPsKwCX2xusUjmJy05FabF
 rNU7T0ORCiXF5kroVNYLI6SFvSUH/4jixyv6GyY+8GPxnDKHPAMOaaL+C1RLdVK0rcJQ
 phxQ==
X-Gm-Message-State: AOJu0YzrTVcREeWe7fl3o672YXAnzA0+tJu9spt6hvJEHXq9iYeWjlnr
 E+3N78Zdb7pCME9yy349LU1DYfFJ5k0tfy6LIqxgL9vei2tSF9Y2+qKTXicJ50k=
X-Gm-Gg: ASbGncvbe2Rfi1/SPuMKsQFN9JDclWcuGZWORrCAbIqehWPV820zd46AMVbsfFsk7mW
 H2DfewfDr269i87ushHtxmu1h+379p2IPp3ii0zoSoScD8adJBC/EyNmD1WDI0I0FaFFq05cFy7
 wad1BOAqMbBjv4UdKEIfncfRzzo0Sen1gumpkHBidBV73EihS0xwEFoZPY9AbDhIf+KrN8wlssg
 N87PjerPEkZtN2TKj+sJ2QeMfDrmTSfL/qQMDAPqcvA3LGa7C7GtLQsb8PuOGdf/jZl6IVSpGtt
 gwufvErHhVyfQFhlG9nt8YCccJcXcvwr6/ntyh2Hx8DILIe+xV9L1K772q2Fs+SqhdniwL8rYRf
 UILY=
X-Google-Smtp-Source: AGHT+IFNyGNnwXyuuLqSIr5Xs3YQoHwM8BkFea4Jb3cE8GV2lXNd1Na87ytEfR1yee5mYavqOuOb0Q==
X-Received: by 2002:a17:902:f550:b0:220:e63c:5b13 with SMTP id
 d9443c01a7336-2219fff4ef2mr273791435ad.46.1740494497597; 
 Tue, 25 Feb 2025 06:41:37 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0b2975sm14838645ad.259.2025.02.25.06.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 06:41:37 -0800 (PST)
Date: Tue, 25 Feb 2025 06:41:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pawel Nicinski <pawel.nicinski@ericsson.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Kamila Swarbula
 <kamila.swarbula@ericsson.com>, EUIR CSI ISP RT TEAM CODE DIGGERS
 Sub-contractors <PDLOLTEAMC@pdl.internal.ericsson.com>
Subject: Re: Bug report for dpdk-stable-22.11.2
Message-ID: <20250225064135.1cd88ff2@hermes.local>
In-Reply-To: <VI1PR07MB558269DB5FBD221349168695FAC42@VI1PR07MB5582.eurprd07.prod.outlook.com>
References: <VI1PR07MB558269DB5FBD221349168695FAC42@VI1PR07MB5582.eurprd07.prod.outlook.com>
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

On Thu, 20 Feb 2025 12:11:08 +0000
Pawel Nicinski <pawel.nicinski@ericsson.com> wrote:

> Hello there,
>=20
>=20
>=20
> I hope you=E2=80=99re having a great day.
>=20
>=20
>=20
> Using the github.com/Ericsson/codechecker<https://github.com/Ericsson/cod=
echecker> tool, we conducted a static analysis of your software. We detecte=
d some potentially critical vulnerabilities related to different areas.
>=20
>=20
>=20
> Please check the attached csv file and make corrections.
>=20
>=20
>=20
> Best regards,
>=20
> Ericsson Team
>=20
>=20

More static analysis is great, but please run on current upstream main bran=
ch not a two year old
release. Looking a few of these were fixed long ago. Also don't include out=
 of tree drivers.
