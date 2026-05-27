Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DEFCD5BC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8870740395;
	Wed, 27 May 2026 13:09:24 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 5577C40285
 for <dev@dpdk.org>; Wed, 27 May 2026 13:09:22 +0200 (CEST)
X-QQ-mid: Yeas8t1779880156t685t09031
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 4281962099054637591
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-5-zaiyuwang@trustnetic.com>
 <20260517163901.744df0fc@phoenix.local>
In-Reply-To: <20260517163901.744df0fc@phoenix.local>
Subject: RE: [PATCH v4 04/20] net/ngbe: fix VF promiscuous and allmulticast
Date: Wed, 27 May 2026 19:09:14 +0800
Message-ID: <00bd01dcedc9$41899fa0$c49cdee0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAsqNvuAByXOzdbU5Q+uw
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MBKLumFSBSSxaN4WOTPLIYP3oNn6pzaPN2GTBVdg8aVDOP8vlbVwMp/R
 Ec2yXzNGj+Z5/gRckr+AMG1DIWHBCpzyPT/p/QBC8Oo1rQ4uDs3bWUez2agHHJNOYAQlWcC
 IIBk5rulBDYPmOggJ1HdS02enX5JRjzZVH89Goa57bwhWEJrlQD5T+svBFxRM3JlPW/lgz0
 v6jDMf5AFL2sXBVsrPXVEtnJyDUa87LOan9XpaVna0AShNbM8JA2uYXfKNYLedPC9Z87Rzl
 jT2ca6iKq3Macekn5SYkllz6SdPhwf+htAfz8CgK4NqlaSjmrjoY0MKVwFTkPEkmF38ohcl
 blH2R60Hw7KmF9F+XeoKE5IdZ0JMXeWRYx6WJDoen7nipT+JdgY9kysBIuq4Y8gd0no/X+o
 zuILwxlcnt2IgFBgEVMhl08oDgbS48rMhewC8L1kvlBirvi1OBefeyVUoqbiDIF2d3ySwMY
 xHpJu+StZ4+06muLJmVu+3AhZGjp9zeSfBaBWyd9ETOLo/dWI3LJfui3ggDGRU8B/stYWm1
 E4FAlxfzZdKsSZqWVH+bWPW2AI1KRA48uxnrZ3kro1RFuts6pLf/AGw/PCN/4ddZPF8Npyf
 GNmJuucD/YCxVeYa6bQ7FmwoY0uQ7V/ZpWKHrvwaeV/eOB+5Z5XpKt+a/SJfUMBeNEs6k4e
 fjUu5WUh5HAzYOCOkHeX+xkcRthgudgi9vJt9YjbiOyHFG8oq4SZv3zU7XNr+1BQ3lzysHK
 EKIGwINLDkbrTOiTXMD7vXsrAqTPN4Vha6vRXabFJ1PyEZbSHCWWWqIP4w3YVQlX2pMGGy9
 sqKeG4utiXTVI1Z4ZG49t9wfrfHSmDNgFw42LEzlCgl9hR6MdB0/qLHcCPa7EXugfBT31ch
 r1hMoQeZhW2/Pfq4RS4ir9hqagVBsCBpQxuvaZf/+Tplils/GBnwyVYDPoHMfFzYqxLM76S
 +it6LxM7ZVx7BOc8SgDi311q/efgGhUpeh8/6qAgRaJ7nsbnYUZxst7G52vhjN5iR3iRdNv
 jM45zu9S6zNWnIRXNUvNAF0MQLR8QfzmZMKQNMkg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, May 18, 2026 7:39 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang
> <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Jiawen Wu <jiawenwu@trustnetic.com>;
> dev@dpdk.org; stable@dpdk.org; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: Re: [PATCH v4 04/20] net/ngbe: fix VF promiscuous and allmulticast
> 
> On Mon, 11 May 2026 18:35:46 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > The configuration of allmulti and promiscuous modes conflicts
> > together. For instance, if we enable promiscuous mode, then enable and
> > disable allmulti, then the promiscuous mode is wrongly disabled.
> >
> > To resolve this, the following changes are made:
> > - do nothing when we set/unset allmulti if promiscuous mode is on
> > - restore the proper mode (none or allmulti) when we disable
> >   promiscuous mode
> >
> > Fixes: 7744e90805b5 ("net/ngbe: add promiscuous and allmulticast ops
> > for VF device")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> > ---
> 
> Worth mentioning, but IMHO this is case of AI being overly pedantic.
> Patch is OK as is.
Thanks.
 

