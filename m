Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91BC8303D
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 01:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1A0F40298;
	Wed,  2 Jul 2025 03:42:07 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id E40C240264
 for <dev@dpdk.org>; Wed,  2 Jul 2025 03:42:04 +0200 (CEST)
X-QQ-mid: Yeas7t1751420516t804t34848
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [125.120.151.178])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6821653162981354144
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<zaiyuwang@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>	<20250613084159.22184-1-jiawenwu@trustnetic.com>	<20250613084159.22184-2-jiawenwu@trustnetic.com>
 <20250701073858.161dce1c@hermes.local>
In-Reply-To: <20250701073858.161dce1c@hermes.local>
Subject: RE: [PATCH v3 01/17] net/txgbe: support flow filter for VF
Date: Wed, 2 Jul 2025 09:41:49 +0800
Message-ID: <051f01dbeaf2$7a719190$6f54b4b0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQGeobqhxUfLqKy/Mu2u5PqQjF1xFQIO55ZOAiUR4IcDD2Ej8rRehkmA
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OFFjJVuQBI5NAANarvm/jhyskcf+uLjBWFGjd8ShWh9v2V1I7jZWMbnz
 9eC56FEF/mBtgudeFg3EGReENmFEvWNUZEULvROpmgFZkd/4B47Ro+miEuDVb5ka9n2Kt7I
 Msl5lxB06fv1OY7UR+3ZQk/DcQNnOKmSIDkcted13tw17vm3F/u2l2y/mwXtt33iPXoTiZw
 GZ9kWQl6d8p0jcO1W7QfOWpwiMy92MP8TdDsmgxzU5JXOycirC6GLC6qYwfD/2WKT/t7e8F
 v850dBLSNTwblLW+VUZ3o9cze2lKPiuQ6QP6C9KohfVB3oYVdv4n+fav2WzCRxIaAOMuW33
 ermQ1s2qbTt7q6TULcJHzHfokss7s//C8v0MMi35WcgT6ECECAuXizpCpydtL73YYIf4fLm
 kw8f+9DWs+6NdBCa3BJA4fCgNMT7NlvDqHkslxp/t3QcVhpYmwZWawWGydJo5pgr1Bgfvrh
 yhMZmaZd7GspWYYRZr7jni1tLajX2dd+f8jfarYFptDfBgxz35rEbWPRNZD1QrIm9iHpYoc
 1VdleChAD8cR6PPMA6+//NEvw5illakW1eF3uM8iD9x2cD9ruZ/CU8D34rqFrqBC32PnfZE
 CV9PGbpGDFVe/50Pi2YABQ+0d00+/lfJyUYn4/WWukY9CWXkDp3q1UyGZSXIpU4J34G2QMS
 a7o5d8WrMaypP3Bo8GcwrjC+7OeWegQJKIb7/SAmtZPpB8Ov56f1O8g8a0HijK5YvaBE49J
 Y81URrmWyYVUAArlAfarSeJ2SscrwKui84j4Z0eBnGj1Ca9gA+yvbupVmtBBBu3Lj3rR+ea
 CvTHTfB+c+vfbum2M+HArTvpzN7HiV8YOcTfcilu4faSQzdbO9GfFkuqV5hJqm5iggT4qBv
 NkEdJ+SK+wJRgrGmUIIvi7pdNVfRRE5LwsdnlHYmg3LJgE85PL9lmbZXKv+AtRJjZ1c07g9
 8cewhsQWgeSKxOrqqgwBBC/3uDfYDak08ND0mn0O+3vYLmpxc4N335MDsAmmzUyrpMT0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
> Sent: Tuesday, July 1, 2025 10:39 PM
> To: Jiawen Wu <jiawenwu@trustnetic.com>
> Cc: dev@dpdk.org; zaiyuwang@trustnetic.com
> Subject: Re: [PATCH v3 01/17] net/txgbe: support flow filter for VF
> 
> On Fri, 13 Jun 2025 16:41:43 +0800
> Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> 
> > +bool txgbe_is_pf(struct txgbe_hw *hw)
> > +{
> > +	switch (hw->mac.type) {
> > +	case txgbe_mac_raptor:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> 
> This is ok as is, but you could make it much simpler as:
> 
> bool txgbe_is_pf(const struct txgbe_hw *hw)
> {
> 	return hw->mac.type == txgbe_mac_raptor;
> }
> 
> Or are you planning for future hardware?

Yes. Other mac types will be added soon.


